class Cart < ActiveRecord::Base
  attr_accessible :complete, :last_modified
    belongs_to :user_client

    has_many :shoppinglists
    has_many :products, :through => :shoppinglists
end
