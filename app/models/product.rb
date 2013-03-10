class Product < ActiveRecord::Base
  attr_accessible :name, :available, :image_url, :price, :qrcode

  has_many :shoppinglists
  has_many :carts, :through => :shoppinglists

  has_many :categorizations
  has_many :categories, :through => :categorizations

  has_many :purchases
  has_many :clients, :through => :purchases

  belongs_to :merchant, :foreign_key => "merchant_id"
end
