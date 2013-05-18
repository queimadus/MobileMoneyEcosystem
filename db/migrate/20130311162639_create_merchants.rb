class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|

      t.integer :user_id

      t.string :name
      t.integer :credit, :decimal, :precision => 8, :scale => 2, :default => 0
      t.string :bank_account

      t.timestamps
    end
  end
end
