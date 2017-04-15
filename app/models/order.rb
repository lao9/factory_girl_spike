class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items

  belongs_to :user

  def order_date
    created_at.in_time_zone("Mountain Time (US & Canada)").strftime("%A %B %e, %Y, %l:%M %p")
  end

  def total_price
    "$%.2f" % order_items.sum(:subtotal)
  end

  def total_quantity
    order_items.sum(:quantity)
  end

  def ordered
    Order.where(status: "ordered")
  end

  def paid
    Order.where(status: "paid")
  end

  def completed
     Order.where(status: "completed")
  end
  def cancelled
     Order.where(status: "cancelled")
  end

  enum status: %w(ordered paid cancelled completed)

end
