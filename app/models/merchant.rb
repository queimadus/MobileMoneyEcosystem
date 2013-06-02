class Merchant < ActiveRecord::Base
  belongs_to :user

  has_many :products
  has_many :orders

  attr_accessible :credit, :bank_account, :name

  validates :name, :presence => true, :uniqueness => true
  validates_associated :user
  validates :credit, :numericality => { :greater_than_or_equal_to => 0 }
  validates :bank_account, :numericality => { :greater_than_or_equal_to => 0 },:allow_nil => true

  before_save :round_price

  def round_price
    self.credit = sprintf("%.2f", self.credit)
  end

end
