class Limit < ActiveRecord::Base
  attr_accessible :max, :period, :starting, :category_id, :client_id

  validates :period, :inclusion => {:in => ["weekly", "monthly", "yearly"]}
  validates_presence_of :max, :category_id, :client_id, :period

  before_save :set_starting_date

  scope :filter_by_categories, lambda{ |name| includes(:category).where(:categories=>{:name=>name}) }


  def set_starting_date
     self.starting = Time.now.to_date if self.starting.nil?
  end

  def current_price
    return 0 if self.max==0

    if self.period=="weekly"
      ending = self.starting + 1.week
    elsif self.period=="monthly"
      ending = self.starting + 1.month
    elsif self.period=="yearly"
      ending = self.starting + 1.year
    end
                                                                        #:complete => true, to only search on archived ones
    Item.where(:category_id => self.category.id ,:cart_id => Cart.where( :client_id => self.client_id )
    .between_dates(self.starting,ending)).sum(:actual_price)
  end

  def credit_percentage
    a = self.current_price
    b = self.max/100.0
    a/b
    #number_with_precision(a/b, :precision => 0)
  end

  def time_percentage
    unless self.starting.nil?
      c = (Time.now.to_date-self.starting).to_i*100
      if self.period=="weekly"
        c / 7
      elsif self.period=="monthly"
        c / 31
      else
        c / 365
      end
    end
  end

  belongs_to :client
  belongs_to :category
end
