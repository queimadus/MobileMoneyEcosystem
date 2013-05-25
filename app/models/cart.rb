class Cart < ActiveRecord::Base
  attr_accessible :client_id, :complete, :last_modified
  belongs_to :client

  has_many :items
  has_many :products, :through => :items

  def self.archived
   where(:complete => true)
  end

  def self.active
    where(:complete => false)
  end

  #deprecated - use between_dates(s,e) instead
  scope :date_between, lambda{ |s,e| where('date(updated_at) >= ? and date(updated_at) <= ?',s.to_s(:db),e.to_s(:db)) }

  def self.between_dates(s,e)
    where('date(updated_at) >= ? and date(updated_at) <= ?',s.to_s,e.to_s)
  end

  def self.from_client(c)
    where(:client_id => c.id)
  end

  def self.new_for_client client
    c = Cart.new(:client_id => client.id, :complete=> false)
    c.total=0
    c
    #temp until migration is ran again
  end

  def as_json(options={})
    {:items => self.items, :total => self.total, :success => self.items.size>0}
  end

end
