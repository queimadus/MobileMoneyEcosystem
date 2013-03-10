class Purchase < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :product
  belongs_to :client

end
