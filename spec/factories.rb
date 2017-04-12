FactoryGirl.define do

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
