class Merchant < ActiveRecord::Base
  belongs_to :user

  has_many :products
  has_many :orders

  attr_accessible :credit, :bank_account, :name

  validates :name, :presence => true, :uniqueness => true
  validates_associated :user
end
