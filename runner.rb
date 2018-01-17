require 'unirest'
require 'tty-table'

response = Unirest.get("http://localhost:3000/all_products_url")

products = response.body

puts JSON.pretty_generate(products)

display_products = []
products.each do |product|
  display_products << {name: product["name"],
                      price: product["price"],
                    }
end

table = TTY::Table.new ['name','price'], [display_products[0], display_products[1]]

table.render