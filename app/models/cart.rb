class Cart

  attr_reader :contents

  def initialize(initial_contents)
     @contents = initial_contents || {}
  end

  def add_item(item_id)
    contents[item_id.to_s] ||= 0
    contents[item_id.to_s] += 1
  end

  def remove_item(item_id)
    contents[item_id.to_s] -= 1
  end

  def update(item_id, new_quantity)
    contents[item_id.to_s] = new_quantity.to_i
  end

  def list
    contents.map do |item_id, quantity|
      OrderItem.new(item_id: item_id,
                    quantity: quantity,
                    subtotal: (quantity * Item.find(item_id).price))
    end
  end

  def cart_total
    list.reduce(0) do |sum, order_item|
      sum + order_item.subtotal
    end
  end

  def cart_quantity
    list.reduce(0) do |sum, order_item|
      sum + order_item.quantity
    end
  end

end
