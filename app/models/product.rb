class Product < ActiveRecord::Base
  attr_accessible :name, :available, :image_url, :price, :qrcode, :reference, :brand, :stock, :id, :image
  has_attached_file :image, :default_url => ":category_image"#"/images/:style/missing.png"
 #, :styles => { :medium => "300x300>", :thumb => "100x100>" },
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
  #validates :qrcode, :presence => true#, :uniqueness => true  #TODO not yet implemented
  validates :price, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :stock, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates_presence_of :categories

  before_create :set_available
  before_save  :round_price

  def round_price
    self.price = sprintf("%.2f", self.price)
  end

  def set_available
    self.available = true
  end


  Paperclip.interpolates :category_image do |attachment, style|
    attachment.instance.categories.first.image
  end

end
