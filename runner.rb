require 'unirest'

response = Unirest.get("http://localhost:3000/all_products_url")

products = response.body

puts JSON.pretty_generate(products)