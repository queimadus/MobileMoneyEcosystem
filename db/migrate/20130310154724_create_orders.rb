class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :merchant_id
      t.boolean :sent, :default => false

      t.timestamps
    end
  end
end
