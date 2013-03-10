class Limit < ActiveRecord::Base
  attr_accessible :max, :type

  belongs_to :client
  belongs_to :category
end
