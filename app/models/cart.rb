class Cart < ActiveRecord::Base
  attr_accessible :complete, :last_modified
    belongs_to :user_client

    has_many :items
    has_many :products, :through => :items


end
