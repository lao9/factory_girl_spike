class AddQuantityAndTotalPriceToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :total_price, :float
    add_column :orders, :quantity, :integer
  end
end
