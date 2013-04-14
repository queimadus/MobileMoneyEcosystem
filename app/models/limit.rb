class Limit < ActiveRecord::Base
  attr_accessible :max, :type, :starting

  validates :type, :inclusion => {:in => ["weekly", "monthly", "yearly"]}

  belongs_to :client
  belongs_to :category
end
