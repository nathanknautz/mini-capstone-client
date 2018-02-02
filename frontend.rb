require 'unirest'
require 'tty-table'
require 'paint'
require_relative 'controllers/products_controller'
require_relative 'models/product'
require_relative 'views/products_views'
require_relative 'controllers/users_controller'

class Frontend
  include ProductsController
  include ProductsViews
  include UsersController
  
  def run
    while true 
      system "clear"
      puts "Hello, what would you like to do?"
      puts "     [1] See all my products?"
      puts "          [1.1] Search my products?"
      puts "          [1.2] Sort products by Price"
      puts "          [1.3] Sort products by Name"
      puts "          [1.4] Sort products by Description"
      puts "          [1.5] Show all products by Category"
      puts "     [2] See one of my products?"
      puts "     [3] Create a new product?"
      puts "     [4] Update a product?"
      puts "     [5] Delete a product?"
      puts "     [6] Add a new user?"
      puts "     [7] View all orders?"
      puts "     [8] Add an item to the cart"
      puts "     [login] Login and create a JSON web token"
      puts "     [logout] Logout and clear JSON web token"
      puts "     [q] Quit the application."

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
      elsif input_option == '1.5'
        puts 
        response = Unirest.get("http://localhost:3000/categories")
        category_hashs = response.body
        puts "Categories"
        puts "-" * 40
        category_hashs.each do |category_hash|
          puts "- #{category_hash["name"]}"
        end
        puts
        print 'Enter a category name: '
        category_name = gets.chomp
        response = Unirest.get("http://localhost:3000/products?category=#{category_name}")
        product_hashs = response.body
        product_hashs.each do |product_hash|
          puts "- #{product_hash["name"]}"
        end
      elsif input_option == "2"
       products_show_action
      elsif input_option == "3"
        products_create_action
      elsif input_option == "4"
        products_update_action
      elsif input_option == "5"
        products_destroy_action
      elsif input_option == '6'
        users_create_action
      elsif input_option == '7'
        #order_hashs = get_request("/orders")
        response = Unirest.get("http://localhost:3000/orders")
        if response.code == 200
          puts JSON.pretty_generate(response.body)
        elsif response.code == 401
          puts "Nah, you're not authorized..."
        end
      elsif input_option == '8'
        puts
        client_params = {}
        print "Enter product id to add: "
        client_params[:product_id] = gets.chomp
        print "Enter quantity to order: "
        client_params[:quantity] = gets.chomp
        #ADD POST REQUEST
      elsif input_option == 'login'
        puts 
        print "Enter email: "
        input_email = gets.chomp
        print "Enter password: "
        input_password = gets.chomp
        response = Unirest.post("http://localhost:3000/user_token",
                                                                  parameters: {
                                                                            auth: {
                                                                                email: input_email,
                                                                                password: input_password
                                                                            }
                                                                    }
                                                                    )
        puts JSON.pretty_generate(response.body)
        jwt = response.body["jwt"]
        Unirest.default_header("Authorization","Bearer #{jwt}")
      elsif input_option == 'logout'
        jwt = ""
        Unirest.clear_default_headers
      elsif input_option == 'q'
        puts "Thanks for visiting my store"
        break
      end 
      gets.chomp
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
