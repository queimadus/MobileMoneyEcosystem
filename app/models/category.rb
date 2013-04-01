class Category < ActiveRecord::Base
  attr_accessible :id, :image_url, :name

  has_many :categorizations
  has_many :products, :through => :categorizations

  has_many :limits
  has_many :user_clients, :through => :limits

  validates :name, :presence => true, :uniqueness => true
end
