class Client < ActiveRecord::Base
  belongs_to :user

  has_many :limits
  has_many :categories, :through => :limits

  has_many :carts
  has_many :transfers
  # has_many :purchases
  # has_many :products, :through => :purchases


end
