class Product < ActiveRecord::Base
  attr_accessible :name, :available, :image_url, :price, :qrcode, :reference, :brand

  has_many :items
  has_many :carts, :through => :items

  has_many :categorizations
  has_many :categories, :through => :categorizations

  # has_many :purchases
  # has_many :clients, :through => :purchases

  belongs_to :merchant

  validates_presence_of :name, :price, :qrcode
  #validates_associated :categories
  #validates_associated :merchant

end
