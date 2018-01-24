require 'unirest'
require 'tty-table'
require 'paint'

system "clear"
puts "Hello, what would you like to do?"
puts "     [1] See all my products?"
puts "     [2] See one of my products?"
puts "     [3] Create a new product?"
puts "     [4] Update a product?"
puts "     [5] Delete a product?"


input_option = gets.chomp

if input_option == "1"
  response = Unirest.get("http://localhost:3000/products/")
  products = response.body
  system "clear"
  puts "How would you like to see the products?"
  puts "[1] JSON or [2] Table?"
  input_option = gets.chomp
  
  if input_option == "1"
    puts JSON.pretty_generate(products)
  elsif input_option == "2"
    display_products = []
    products.each do |product|
      display_products << [product["name"],product["price"],product["description"]]                   
    end
    table = TTY::Table.new ['Name','Price','Description'], display_products
    puts table.render(:unicode)
  end 

elsif input_option == "2"
  system "clear"
  print "Enter product ID: "
  input_id = gets.chomp
  response = Unirest.get("http://localhost:3000/products/#{input_id}")
  product = response.body 
  puts JSON.pretty_generate(product)

elsif input_option == "3"
  product_data = {}
  system "clear"
  print "Name: "
  product_data[:name] = gets.chomp
  print "Price: "
  product_data[:price] = gets.chomp
  print "Image URL: "
  product_data[:image_url] = gets.chomp
  print "Description: "
  product_data[:description] = gets.chomp
  print "In Stock? (true/false): "
  product_data[:in_stock] = gets.chomp
  response = Unirest.post("http://localhost:3000/products",
                          parameters: product_data)
  if response.code == 200
    product_data = response.body
    puts JSON.pretty_generate(product_data)
  else
    errors = response.body["errors"]
    errors.each do |error|
    puts error
    end
  end

elsif input_option == "4"
  system "clear"
  print "Enter product ID: "
  input_id = gets.chomp
  response = Unirest.get("http://localhost:3000/products/#{input_id}")
  product = response.body 
  product_data = {}
  print "Name  (#{product["name"]}): "
  product_data[:name] = gets.chomp
  print "Price  (#{product["price"]}): "
  product_data[:price] = gets.chomp
  print "Image URL   (#{product["image_url"]}): "
  product_data[:image_url] = gets.chomp
  print "Description:    (#{product["description"]}): "
  product_data[:description] = gets.chomp
  print "In Stock?:    (#{product["in_stock"]}): "
  product_data[:in_stock] = gets.chomp
  product_data.delete_if {|key,value| value.empty?}

  response = Unirest.patch("http://localhost:3000/products/#{input_id}",
                          parameters: product_data)

elsif input_option == "5"
  system "clear"
  print "Enter product ID: "
  input_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/products/#{input_id}")
  data = response.body
  puts data["message"]
end 

