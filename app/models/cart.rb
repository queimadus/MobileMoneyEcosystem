class Cart < ActiveRecord::Base
  attr_accessible :complete, :last_modified
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

  def self.from(c)

    where(:client_id => c.id)
  end

end
