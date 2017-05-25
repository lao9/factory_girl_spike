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


end
