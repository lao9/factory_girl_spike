class AddPaperclipFieldsToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :image_file_name,    :string
    add_column :items, :image_content_type, :string
    add_column :items, :image_file_size,    :integer
    add_column :items, :image_updated_at,   :datetime
  end
end
