class CreateShoppinglists < ActiveRecord::Migration
  def change
    create_table :shoppinglists do |t|

      t.integer :cart_id
      t.integer :product_id

      t.datetime :created_at

      t.timestamps
    end
  end
end
