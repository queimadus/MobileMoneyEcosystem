class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :image_url
      t.string :name
      t.string :color

      t.timestamps
    end
  end
end
