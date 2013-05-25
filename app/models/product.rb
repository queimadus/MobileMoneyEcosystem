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
  validates :qrcode, :presence => true, :uniqueness => true
  validates :price, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :stock, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates_presence_of :categories

  before_create :set_available
  before_save  :round_price

  scope :filter_by_categories, lambda{ |name| includes(:categories).where(:categories=>{:name=>name}) }

  def round_price
    self.price = sprintf("%.2f", self.price)
  end

  def set_available
    self.available = true
  end

  def set_hash
    token = ""
    begin
      token = SecureRandom.urlsafe_base64()
    end while Product.find_by_qrcode(token)

    self.qrcode = token
  end

  def will_break_limit client
      limit = Limit.where(:category_id => self.categories.first.id, :client_id => client.id).first
      return false if limit.nil?
      limit.current_price+self.price > limit.max
  end

  def will_break_cart client
    cart = Cart.active.from_client(client).first
    if cart.nil?
      cart = Cart.new_for_client client
      cart.save
    end

    cart.total+self.price>client.credit
  end

  def add_to_cart client, qt
    cart = Cart.active.from_client(client).first
    if cart.nil?
      cart = Cart.new_for_client client
      cart.save
    end

    cart.items.each do |i|
      return false if i.product.id==self.id
    end

    item = Item.new(:product_id => self.id,
                    :actual_price => self.price,
                    :category_id => self.categories.first.id,
                    :quantity => qt,
                    :cart_id => cart.id)

    cart.total+=item.actual_price
    cart.save
    item.save
  end

  Paperclip.interpolates :category_image do |attachment, style|
    attachment.instance.categories.first.image
  end

  def as_json(options={})
    {:id => self.id, :name => self.name,:brand => self.brand, :image => self.image.url,
     :merchant => self.merchant.name ,:category => self.categories.first.name,:price => self.price}
  end

end
