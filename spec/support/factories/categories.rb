FactoryGirl.define do
  category_names = [
                "Kosher",
                "Bread and Butter",
                "Sweet Gherkins",
                "Dill",
                "Meat"
              ]

  sequence :category_name, category_names.cycle do |n|
    "#{n}"
  end

  factory :category do
    name { generate(:category_name) }

    factory :category_with_items do
      items {create_list(:item, 2)}
    end
  end
end
