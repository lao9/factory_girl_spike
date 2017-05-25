class Item < ApplicationRecord
  has_many :category_items
  has_many :categories, through: :category_items
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews

  validates :price, presence: true, :numericality => {greater_than: 0}
  validates :description, presence: true
  validates :title, presence: true, uniqueness: true
end
