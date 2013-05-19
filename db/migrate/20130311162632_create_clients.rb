class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|

      t.integer :user_id

      t.decimal :credit, :decimal, :precision => 8, :scale => 2, :default => 0
      t.date :dob
      t.string :sex, :first_name, :last_name

      t.timestamps
    end
  end
end
