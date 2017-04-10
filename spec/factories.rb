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
  end

end
