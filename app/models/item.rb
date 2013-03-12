class Item < ActiveRecord::Base
  attr_accessible :cart_id, :order_id, :product_id, :quantity

  belongs_to :cart
  belongs_to :product
  belongs_to :order

end
