class AddTimestampsToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :created_at, :datetime, null: false
    add_column :orders, :updated_at, :datetime, null: false
  end
end
