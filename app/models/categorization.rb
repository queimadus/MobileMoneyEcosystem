class Categorization < ActiveRecord::Base
  attr_accessible :category_id, :created_at, :product_id

  belongs_to :category
  belongs_to :product
end
