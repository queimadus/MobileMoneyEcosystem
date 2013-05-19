class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|

      t.integer :client_id
      t.boolean :complete, :default => false
      t.decimal :total, :decimal, :precision => 8, :scale => 2
      t.string  :categories

      t.timestamps
    end
  end
end
