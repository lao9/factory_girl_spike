FactoryGirl.define do

  factory :cart, class: Cart do
    skip_create
    initial_contents { ({"1"=>1}) }
    initialize_with { new(initial_contents) }
  end

  factory :order_item do
    order
    item
    sequence :quantity do |n|
      n
    end
    sequence :subtotal do |n|
      n.to_f
    end
  end

  factory :review do
    user
    item
    sequence :title do |n|
      "title #{n}"
    end
    body "body"
    sequence :rating do
      rand(1..5)
    end
  end

  factory :order do
    user
    sequence :status do |n|
      ["ordered", "paid", "completed"].sample
    end
    factory :order_with_many_items do
      order_items {create_list(:order_item, 2)}
    end
  end



  factory :category_item do
    category
    item
  end

end
