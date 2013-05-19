class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :quantity, :default => 1
      t.integer :cart_id
      t.integer :product_id
      t.integer :order_id
      t.decimal :actual_price, :precision => 8, :scale => 2, :default => 0
      t.integer :category_id
      t.timestamps
    end
  end
end
