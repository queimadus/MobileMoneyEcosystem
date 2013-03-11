class Transfer < ActiveRecord::Base
   attr_accessible :amount, :date, :endpoint

   has_one :client
end
