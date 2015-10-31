require 'digest/sha2'

class User < ActiveRecord::Base
  has_many :orders
  has_many :products
  has_many :croplands
  has_one :customer_info, :dependent => :destroy
  accepts_nested_attributes_for :customer_info

  ADMIN_NAMES = %w(菜农 物流 菜品管理员 区域经理 财务 总管理)
  PRIORITY_NAMES = %w(顾客 菜农 物流 菜品管理员 区域经理 财务 总管理)
  ADMIN_MAP = {'顾客' => 0, '菜农' => 1, '物流' => 2, '菜品管理员'=> 3, '区域经理' => 4, '财务' => 5, '总管理' => 6}

  validates :name, :presence => true, :uniqueness => true
  validates :priority, :presence => true
  validates :openpassword, :confirmation => true
  attr_accessor :openpassword_confirmation
  attr_reader :openpassword

  validate  :password_must_be_present

  def priority_name
    return PRIORITY_NAMES[self.priority]
  end

  def priority_name=(priority_name)
    @priority_name = priority_name
    self.priority = ADMIN_MAP[priority_name]

  end

  def openpassword=(password)
    @openpassword = password
    generate_salt
    self.hashed_password = self.class.encrypt_password(password, salt)
  end

  def User.authenticate(name, password)
    if user = find_by_name(name)
      if user.hashed_password == encrypt_password(password, user.salt)
        user
      end
    end
  end

  def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "wibble" + salt)
  end


  private

  def password_must_be_present
    errors.add(:openpassword, "密码不能为空") unless hashed_password.present?
  end

  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  after_destroy :ensure_an_admin_remains

  def ensure_an_admin_remains
    unless (User.find_by priority: ADMIN_MAP['总管理'])
      raise "不能删除最后的总管理员"
    end
  end
end