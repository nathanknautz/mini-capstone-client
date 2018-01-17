require 'unirest'
require 'tty-table'
require 'paint'

response = Unirest.get("http://localhost:3000/all_products_url")

products = response.body



display_products = []
products.each do |product|
  display_products << [product["name"],product["price"],product["description"]]                   
end

table = TTY::Table.new ['Name','Price','Description'], display_products


puts Paint['These are my products', 'Snow']

puts "Would you like to see the [1] JSON or the [2] Table version?"
input = gets.chomp.to_i
if input == 1
  puts JSON.pretty_generate(products)
else
  puts table.render(:unicode)
end