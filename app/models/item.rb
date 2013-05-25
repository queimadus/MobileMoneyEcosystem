class Item < ActiveRecord::Base
  attr_accessible :cart_id, :order_id, :product_id, :quantity, :actual_price, :category_id

  belongs_to :cart
  belongs_to :product
  belongs_to :order
  has_one :category

  validates :quantity, :presence => true, :numericality => { :greater_than_or_equal_to => 1 }

  before_save  :round_price

  def self.between_dates(s,e)
    where('date(items.updated_at) >= ? and date(items.updated_at) <= ?',s.to_s,e.to_s)
  end

  def round_price
    self.actual_price = sprintf("%.2f", self.actual_price)
  end

  def as_json(options={})
    {:id => self.product_id, :name => self.product.name,:brand => self.product.brand, :quantity => self.quantity, :image => self.product.image.url,
     :merchant => self.product.merchant.name ,:category => Category.find(self.category_id).name,:price => self.actual_price}
  end
end
