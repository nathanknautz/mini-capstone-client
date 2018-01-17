require 'unirest'
require 'tty-table'

response = Unirest.get("http://localhost:3000/all_products_url")

products = response.body

puts JSON.pretty_generate(products)

display_products = []
products.each do |product|
  display_products << [product["name"],product["price"],product["description"]]
                    
end

table = TTY::Table.new ['Name','Price','Description'], display_products
#p display_products[0]
puts table.render(:unicode)