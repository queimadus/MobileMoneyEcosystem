class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|

      t.integer :user_id

      t.integer :credit
      t.string :bank_account

      t.timestamps
    end
  end
end
