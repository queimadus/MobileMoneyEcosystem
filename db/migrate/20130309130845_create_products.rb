class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|

      t.integer :merchant_id

      t.string :name
      t.boolean :available
      t.string :image_url
      t.integer :price
      t.string :qrcode
      t.string :reference
      t.string :brand

      t.timestamps
    end
  end
end
