class Product < ActiveRecord::Base
  default_scope {order('title')}
  has_many :line_items
  has_many :orders, :through => :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  validates :image_url, :format => {
                :with => %r{\.(gif|jpg|png|jpeg)\z}i,
                :message => '必须上传图片.'
                      }
=begin
  attr_accessor :picture_update_url
  attr_accessor :image_url

  def updateURL(image_url)
     self.picture_update_url = image_url
  end

  def image_url=(image_url)
    if (self.picture_update_url)
      self.image_url = self.picture_update_url
    else
      self.image_url = image_url
    end
  end
=end

  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end

end
