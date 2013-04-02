class Category < ActiveRecord::Base
  attr_accessible :id, :image_url, :name, :color

  has_many :categorizations
  has_many :products, :through => :categorizations

  has_many :limits
  has_many :user_clients, :through => :limits

  validates :name, :presence => true, :uniqueness => true

  def image
    if image_url.nil?
      "http://cuerpos-perfectos.es/img/product/thumb/4ea4b24053.jpg"
    else
      image_url
    end
  end

end
