require 'digest/sha2'

class User < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  validates :openpassword, :confirmation => true
  attr_accessor :openpassword_confirmation
  attr_reader :openpassword

  validate  :password_must_be_present

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
    if User.count.zero?
      raise "不能删除最后的管理员"
    end
  end
end