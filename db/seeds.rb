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


User.create(first_name: "Dr", last_name: "Picklemeister", email: "a@a.com", password: "password", role: 1)
User.create(first_name: "Albert", last_name: "Dibbons", email: "a1@a.com", password: "password")
User.create(first_name: "Bethany", last_name: "Culberth", email: "a2@a.com", password: "password")
User.create(first_name: "Charles", last_name: "Mielnicowiktz", email: "a3@a.com", password: "password")
User.create(first_name: "Diana", last_name: "Crivvens", email: "a4@a.com", password: "password")
User.create(first_name: "Edward", last_name: "Donutbaker", email: "a5@a.com", password: "password")


(1..6).each do |n|
  user = User.find(n)
  subtotal = Item.find(1).price
  user.orders.create.order_items.create(item_id: 1, quantity: 1, subtotal: subtotal)
  user.orders.create.order_items.create(item_id: 1, quantity: 2, subtotal: (subtotal * 2) )
  subtotal = Item.find(3).price
  user.orders.create.order_items.create(item_id: 5, quantity: 5, subtotal: (subtotal * 5) )
end
