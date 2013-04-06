class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|

      t.integer :merchant_id

      t.string :name
      t.boolean :available, :default => true
      t.string :image_url
      t.decimal :price, :default => 0
      t.string :qrcode
      t.string :reference
      t.string :brand
      t.integer :stock, :default => 0

      t.timestamps
    end
  end
end
