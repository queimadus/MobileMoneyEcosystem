class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|

      t.integer :user_id

      t.string :name
      t.integer :credit, :default => 0
      t.string :bank_account

      t.timestamps
    end
  end
end
