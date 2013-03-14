class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|

      t.integer :client_id
      t.boolean :complete, :default => false

      t.timestamps
    end
  end
end
