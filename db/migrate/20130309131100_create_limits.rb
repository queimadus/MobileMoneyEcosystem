class CreateLimits < ActiveRecord::Migration
  def change
    create_table :limits do |t|

      t.integer :client_id
      t.integer :category_id

      t.integer :max
      t.string :type

      t.timestamps
    end
  end
end
