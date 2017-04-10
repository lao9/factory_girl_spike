class CreateCatgoryItems < ActiveRecord::Migration[5.0]
  def change
    create_table :category_items do |t|
      t.references :item, foreign_key: true
      t.references :category, foreign_key: true
    end
  end
end
