class Product < ActiveRecord::Base
  attr_accessible :name, :available, :image_url, :price, :qrcode, :reference, :brand, :stock, :id

  has_many :items
  has_many :carts, :through => :items

  has_many :categorizations
  has_many :categories, :through => :categorizations

  # has_many :purchases
  # has_many :clients, :through => :purchases

  belongs_to :merchant


  #validates_associated :categories
  #validates_associated :merchant
  validates :name, :presence => true
  validates :qrcode, :presence => true, :uniqueness => true  #TODO not yet implemented
  validates :price, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :stock, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates_presence_of :categories


  def image
    if image_url.nil?
      "http://www.street61.com/FRUITS&VEGETABLES-bananas.jpg"
    else
      image_url
    end
  end

end
