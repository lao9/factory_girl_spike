class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :item, foreign_key: true
      t.integer :rating
      t.text :body
      t.string :title
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
