class Cart < ActiveRecord::Base
  attr_accessible :complete, :last_modified
    belongs_to :client

    has_many :items
    has_many :products, :through => :items

    def self.active
      Cart.where(:complete => false).first
    end

   scope :date_between, lambda{ |s,e| where('date(updated_at) >= ? and date(updated_at) <= ?',s.to_s(:db),e.to_s(:db)) }
end
