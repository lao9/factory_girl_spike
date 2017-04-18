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

  def self.bestselling
    OrderItem.group(:item).order('count_id').limit(1).count(:id).first
  end

  def self.total_revenue
    "$%.2f" % Order.joins(:order_items).where.not(status: :cancelled).sum(:subtotal)
  end

  def self.trailing_revenue(q = 7)
    "$%.2f" % Order.where("orders.created_at >= ?", q.days.ago).where.not(status: :cancelled).joins(:order_items).sum(:subtotal)
  end

  enum status: %w(ordered paid cancelled completed)

end
