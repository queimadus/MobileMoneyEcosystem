class Order < ActiveRecord::Base
  attr_accessible :merchant_id, :sent

  has_many :items
  belongs_to :merchant

  def self.between_dates(s,e)
    where('date(updated_at) >= ? and date(updated_at) <= ?',s.to_s,e.to_s)
  end

  def self.from(m)

    where(:merchant_id => m.id)
  end

end
