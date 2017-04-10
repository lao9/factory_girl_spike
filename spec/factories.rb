FactoryGirl.define do

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
