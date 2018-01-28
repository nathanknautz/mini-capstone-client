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
    puts "          [1.2] Sort products by Price"
    puts "          [1.3] Sort products by Name"
    puts "          [1.4] Sort products by Description"
    puts "     [2] See one of my products?"
    puts "     [3] Create a new product?"
    puts "     [4] Update a product?"
    puts "     [5] Delete a product?"

    input_option = gets.chomp

    if input_option == "1"
      products_index_action
    elsif input_option =="1.1"
      products_search_action 
    elsif input_option == '1.2'
      products_sort_action("price")
    elsif input_option == '1.3'
      products_sort_action("name")
    elsif input_option == '1.4'
      products_sort_action("description")
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

  private 
  
  def get_request(url, product_data={})
    response = Unirest.get("http://localhost:3000/#{url}", parameters: product_data).body
  end

  def post_request(url, product_data={})
    response = Unirest.post("http://localhost:3000/#{url}", parameters: product_data).body
  end

  def patch_request(url, product_data={})
    response = Unirest.patch("http://localhost:3000/#{url}", parameters: product_data).body
  end

  def delete_request(url, product_data={})
    response = Unirest.delete("http://localhost:3000/#{url}", parameters: product_data).body
  end

end
