class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items

  def order_date
    order_items.first.created_at.in_time_zone("Mountain Time (US & Canada)").strftime("%A %B %e, %Y, %l:%m %p")
  end

end
