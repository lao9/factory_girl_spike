FactoryGirl.define do

  sequence :item_description do |n|
    "I am the ##{n} pickle!"
  end

  factory :item do
    sequence :title do |n|
      "Pickle #{n}"
    end

    description {generate(:item_description)}

    sequence :image_url do |n|
      Faker::Avatar.image("pickle-#{n}")
    end

    sequence :price do |n|
      n.to_f
    end

    factory :item_with_categories do
      categories {create_list(:category, 2)}
    end

    factory :item_with_orders do
      orders {create_list(:order, 3)}
    end
  end
end
