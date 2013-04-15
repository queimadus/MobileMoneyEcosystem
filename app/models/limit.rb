class Limit < ActiveRecord::Base
  attr_accessible :max, :period, :starting

  validates :period, :inclusion => {:in => ["weekly", "monthly", "yearly"]}

  belongs_to :client
  belongs_to :category
end
