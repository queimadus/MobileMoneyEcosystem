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

  def self.clear_from_client client
    c = Cart.active.from_client(client).first
    if c.nil?
      return  false
    else
      c.items.each do |item|
        Item.destroy(item.id)
      end
      c.destroy
      return true
    end
  end

  def self.buy_from_client client
    c = Cart.active.from_client(client).first
    return false if c.total > client.credit

    items = c.items.joins("INNER JOIN Products ON Items.product_id=Products.id")
              .select("Items.*,merchant_id")

    orders = {}
    items.each do |i|
      order_id = i.merchant_id
      if orders.has_key?(order_id)
        orders[order_id][:orders] << i
        orders[order_id][:total]  += i.actual_price*i.quantity
      else
         orders[order_id] = {:orders => [i], :total => i.actual_price*i.quantity}
      end
    end

    orders.each do |merc_id,o|
      ord =  Order.new(:merchant_id => merc_id, :sent => false)
      ord.save
      o[:orders].each do |it|
        it.order_id = ord.id
        it.save
      end
    end

    c.complete=true
    c.save
  end

  def as_json(options={})
    {:items => self.items, :total => self.total, :success => self.items.size>0}
  end

end
