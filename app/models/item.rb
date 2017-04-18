class Item < ApplicationRecord
  has_many :category_items
  has_many :categories, through: :category_items
  has_many :order_items
  has_many :orders, through: :order_items

  has_attached_file :image, styles: { medium: "200x200>", small: "100x100>" }

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  validates :price, presence: true, :numericality => {greater_than: 0}
  validates :description, presence: true
  validates :title, presence: true, uniqueness: true
end
