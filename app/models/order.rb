class Order < ActiveRecord::Base
  attr_accessible :merchant_id, :sent

  has_many :items
  belongs_to :merchant

end
