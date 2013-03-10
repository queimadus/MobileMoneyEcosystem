class Transfer < ActiveRecord::Base
   attr_accessible :amount, :date, :endpoint

   initialize_attributes

   has_one :client
end
