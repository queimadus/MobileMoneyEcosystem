class Client < ActiveRecord::Base
  belongs_to :user

  has_many :limits
  has_many :categories, :through => :limits

  has_many :carts
  has_many :transfers
  # has_many :purchases
  # has_many :products, :through => :purchases

  attr_accessible :dob, :credit, :sex, :first_name, :last_name

  #validates_presence_of :user
 # validates :first_name, :presence => true
 # validates :last_name, :presence => true

  before_save :set_name
  before_save :set_sex

  def set_name
    if first_name.nil? or last_name.nil?
      first_name = "User"
      last_name = "unknown"
    end
  end

  def set_sex
    if sex.nil? or sex!="Male" or sex!="Female"
      sex = "N/A"
    end
  end
end
