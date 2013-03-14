class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|

      t.integer :user_id

      t.integer :credit, :default => 0
      t.date :dob

      t.timestamps
    end
  end
end
