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

    password "password"

    factory :user_with_orders do
      orders {create_list(:order_with_items, 2)}
    end
  end
end
