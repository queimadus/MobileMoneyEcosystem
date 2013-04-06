class ModifyPriceToDecimal < ActiveRecord::Migration
  def up
    change_column :products, :price, :decimal
  end

  def down
    change_column :products, :price, :integer
  end
end
