class Item < ActiveRecord::Base
  attr_accessible :cart_id, :order_id, :product_id, :quantity, :actual_price, :category_id

  belongs_to :cart
  belongs_to :product
  belongs_to :order
  has_one :category



  before_save  :round_price

  def round_price
    self.actual_price = sprintf("%.2f", self.actual_price)
  end
end
