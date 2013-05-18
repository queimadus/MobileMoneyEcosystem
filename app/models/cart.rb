class Cart < ActiveRecord::Base
  attr_accessible :complete, :last_modified
    belongs_to :client

    has_many :items
    has_many :products, :through => :items

    def self.active(id)
      Cart.where(:complete => false,:client_id => id)
    end
end
