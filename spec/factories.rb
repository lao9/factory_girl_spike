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

  factory :user do
    sequence :first_name do |n|
      "Dill #{n}"
    end

    sequence :last_name do |n|
      "Pickles #{n}"
    end

    sequence :email do |n|
      "picklelover#{n}@pickle.com"
    end

    sequence :password do |n|
      "vlassic#{n}"
    end

    sequence :street do |n|
      "#{n} Pickle Lane"
    end

    sequence :city do |n|
      "Green#{n}lawn"
    end

    state 'NY'

    sequence :zipcode do |n|
      "1174#{n}"
    end

    factory :user_without_address do
      street nil
      city nil
      state nil
      zipcode nil
    end

    factory :user_with_orders do
      orders {create_list(:order_with_many_items, 2)}
    end
  end

  factory :item do
    sequence :title do |n|
      "Pickle #{n}"
    end

    sequence :description do |n|
      "I am the ##{n} pickle!"
    end

    sequence :image_url do |n|
      Faker::Avatar.image("pickle-#{n}")
    end

    sequence :price do |n|
      n.to_f
    end


    factory :item_with_categories do
      categories {create_list(:category, 2)}
    end

    factory :item_with_many_orders do
      order_items {create_list(:order_item, 2)}
    end
  end

  factory :category_item do
    category
    item
  end

  factory :category do
    sequence :name do |n|
      "category#{n}"
    end

    factory :category_with_items do
      items {create_list(:item, 2)}
    end
  end

end
