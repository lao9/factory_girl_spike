# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

category = Category.create(name:"Spicy")
category.items.create(title: "Assorted Peppers", description: "A variety of spicy peppers. Adds a little zip to any dish.", price: 8, image_url: "assorted_peppers_jar.jpg")
category.items.create(title: "McClures Spicy", description: "These classic spicy pickles have just the right amount of bite.", price: 7, image_url: "mcclures_jar.jpg")
category.items.create(title: "Seattle Spicy Dill", description: "A dill pickle with a fair amount of heat. Made with all fresh ingredients.", price: 8, image_url: "seattle_spicy_pickle.jpg")
# category.items.create(title: new_title, description: descriptions.sample, price: prices.sample, image_url: "")

category = Category.create(name:"Dill")
category.items.create(title: "Backyard Brine", description: "Everything: A classic dill pickle, but with a bit of everything flavor-wise thrown in.", price: 7, image_url: "Backyard_brine_pickle_Everything_6163209103781.jpg")
category.items.create(title: "Brooklyn Brine", description: "NYC Deli: Tastes just like it's straight from you favorite neighborhood deli.", price: 6, image_url: "brooklyn_dill.jpg")
category.items.create(title: "Indiana Moonshine", description: "An Indiana style whiskey pickle in Hotel Tango Distillery moonshine.", price: 11, image_url: "indiana_moonshine.jpeg")
category.items.create(title: "Vampire Slayers", description: "Dill pickles with a heavy dose of fresh garlic.", price: 7, image_url: "vampire_dill.jpg")

category = Category.create(name:"Vegetable")
category.items.create(title: "Orange Cumin Carrots", description: "Pickled carrots with a bit of Eastern spice.", price: 8, image_url: "cumin_carrots.jpg")
category.items.create(title: "Ginger Beets", description: "A delicious combination on flavors", price: 7, image_url: "ginger_beets.jpg")
# category.items.create(title: new_title, description: descriptions.sample, price: prices.sample, image_url: "")

category = Category.create(name:"Fruit")
category.items.create(title: "Amish Wedding Peaches", description: "Juicy, sweet, and just plain delicious", price: 6, image_url: "peaches.jpg")
category.items.create(title: "Pickled Plum", description: "A Japanese favorite", price: 8, image_url: "plum.jpeg")
category.items.create(title: "Strawberries", description: "Great for making a sauce or pie filling", price: 5, image_url: "strawberry.jpg")

category = Category.create(name:"Meat")
category.items.create(title: "Bay View Pickled Eggs", description: "A staple food of old dive bars around the country", price: 10, image_url: "eggs_jar.jpg")
category.items.create(title: "Herring Filets", description: "Pickled in a white wine sauce. A treat no Scandinavian can resist.", price: 7, image_url: "Herring_Filets_jar.png")
category.items.create(title: "Mystery Meat", description: "??????????", price: 2, image_url: "mystery_jar.jpg")
category.items.create(title: "Pig Lips", description: "Yep, this is a thing for some reason.", price: 4, image_url: "pig_lips.jpg")
category.items.create(title: "Pig Snout", description: "Why? Just...why??", price: 3, image_url: "snout_jar.jpg")
category.items.create(title: "Canned Squirrel", description: "Back by popluar demand.", price: 8, image_url: "squirrel_in_jar.jpg")
category.items.create(title: "Pork Tidbits", description: "Your guess is as good as mine", price: 2, image_url: "tidbits_jar copy.jpg")



User.create(first_name: "Dr", last_name: "Picklemeister", email: "a@a.com", password: "password", role: 1)
User.create(first_name: "Albert", last_name: "Dibbons", email: "a1@a.com", password: "password")
User.create(first_name: "Bethany", last_name: "Culberth", email: "a2@a.com", password: "password")
User.create(first_name: "Charles", last_name: "Mielnicowiktz", email: "a3@a.com", password: "password")
User.create(first_name: "Diana", last_name: "Crivvens", email: "a4@a.com", password: "password")
User.create(first_name: "Edward", last_name: "Donutbaker", email: "a5@a.com", password: "password")
