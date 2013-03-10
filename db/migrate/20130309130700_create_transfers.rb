class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|

      t.integer :client_id
      t.integer :amount
      t.date :date
      t.string :endpoint

      t.timestamps
    end
  end
end
