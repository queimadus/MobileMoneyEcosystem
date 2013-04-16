class Limit < ActiveRecord::Base
  attr_accessible :max, :period, :starting, :category_id, :client_id

  validates :period, :inclusion => {:in => ["weekly", "monthly", "yearly"]}
  validates_presence_of :max, :category_id, :client_id, :period

  belongs_to :client
  belongs_to :category
end
