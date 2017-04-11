# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
titles = ["Pincus's Pickled Pigs Feet", "Oliveri's  Olives", "Mossefin's Pickled Moose", "Glass's Glass Jars", ]
descriptions = ["Tasty stuff", "The Best", "Pickled goodness", "Addictive, yet lacking nutrition"]
adjectives = ["sweet", "spicy", "tangy", "dill"]
prices = Array(1..100)

categories = ["Spicy", "Organic", "Fruit", "Dill", "Meat"]
categories.each do |category_name|
  category = Category.create(name: category_name)
  titles.each do |new_title|
    category.items.create(title: new_title, description: descriptions.sample, price: prices.sample, image_url: "http://loremflickr.com/320/240/#{adjectives.sample},pickle/all")
  end
end
