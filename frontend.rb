require 'unirest'
require 'tty-table'
require 'paint'
require_relative 'controllers/products_controller'
require_relative 'models/product'
require_relative 'views/products_views'

class Frontend
  include ProductsController
  include ProductsViews

  def run
    system "clear"
    puts "Hello, what would you like to do?"
    puts "     [1] See all my products?"
    puts "          [1.1] Search my products?"
    puts "     [2] See one of my products?"
    puts "     [3] Create a new product?"
    puts "     [4] Update a product?"
    puts "     [5] Delete a product?"

    input_option = gets.chomp

    if input_option == "1"
      products_index_action
    
    elsif input_option =="1.1"
      system "clear"
      print "Enter search term: "
      search_term = gets.chomp
      response = Unirest.get("http://localhost:3000/products?search=#{search_term}")
      products = response.body
      puts JSON.pretty_generate(products)
    
    elsif input_option == "2"
     products_show_action
    
    elsif input_option == "3"
      products_create_action
   
    elsif input_option == "4"
      products_update_action
   
    elsif input_option == "5"
      products_destroy_action
    end 

  end
end
