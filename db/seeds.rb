# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require "json"

Ingredient.destroy_all

url = "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
ingredient_serialized = open(url).read
ingredients = JSON.parse(ingredient_serialized)

ingredients_parsed = ingredients['drinks']

ingredients_parsed.each do |ingredient|
  Ingredient.create(name: ingredient['strIngredient1'])
end

Cocktail.destroy_all
url = "http://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail"
cocktails_serialized = open(url).read
cocktails = JSON.parse(cocktails_serialized)

cocktails_parsed = cocktails['drinks']

cocktails_parsed.each do |cocktail|
  coquetel = Cocktail.new(name: cocktail['strDrink'])
  coquetel.remote_photo_url = cocktail['strDrinkThumb']
  coquetel.save
end
