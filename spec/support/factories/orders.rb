FactoryGirl.define do
  factory :order do
    user
    factory :order_with_items do
      items {create_list(:item, 3)}
    end
  end
end
