class Limit < ActiveRecord::Base
  attr_accessible :max, :period, :starting, :category_id, :client_id

  validates :period, :inclusion => {:in => ["weekly", "monthly", "yearly"]}
  validates_presence_of :max, :category_id, :client_id, :period

  before_save :set_starting_date

  scope :filter_by_categories, lambda{ |name| includes(:category).where(:categories=>{:name=>name}) }


  def set_starting_date
     self.starting = Time.now.to_date if self.starting.nil?
  end

  belongs_to :client
  belongs_to :category
end
