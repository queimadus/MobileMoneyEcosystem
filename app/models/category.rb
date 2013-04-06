class Category < ActiveRecord::Base
  attr_accessible :id, :image_url, :name, :color

  has_many :categorizations
  has_many :products, :through => :categorizations

  has_many :limits
  has_many :user_clients, :through => :limits

  validates :name, :presence => true, :uniqueness => true

  def image
    if image_url.nil? or image_url.blank?
      "/assets/vegetais.jpg"
    else
      image_url
    end
  end

end
