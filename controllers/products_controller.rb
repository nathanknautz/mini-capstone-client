module ProductsController

  def products_show_action
    system "clear"
    input_id = products_id_form
    product_hash = get_request("/products/#{input_id}")
    product = Product.new(product_hash)
    products_show_view(product)

    puts "press enter to continue or type 'O' to order"
    user_choice = gets.chomp
    if user_choice == 'O'
      print "Enter a quantity to order:"
      input_quantity = gets.chomp
      client_params = { product_id: input_id,
                       quantity: input_quantity
                       
                       }
      #json_data = post_request("orders", client_params)
      response = Unirest.post("http://localhost:3000/carted_products", parameters: client_params)
      if response.code == 200
        puts JSON.pretty_generate(response.body)
      elsif response.code == 401
        puts "Nah bro, you gotta be authorized."
      end
    end
  end

  def products_index_action
    system "clear"
    product_hashs = get_request("/products")
    products = Product.convert_hashs(product_hashs)
    products_index_view(products)
  end

  def products_create_action
    system "clear"
    product_data = products_new_form
    #json_data = post_request("/products",product_data)
    response = Unirest.post("http://localhost:3000/products",parameters: product_data)
    if response.code == 200
      product = Product.new(response.body)
      products_show_view(product)
    elsif response.code == 422
      errors = response.body["errors"]
      products_errors_view(errors)
    elsif response.code == 401
      puts JSON.pretty_generate(response.body)
    end
  end

  def products_update_action
    system "clear"
    input_id = products_id_form
    product_hash = get_request("products/#{input_id}")
    product = Product.new(product_hash)
    product_data = products_update_form(product)
    #json_data = patch_request("/products/#{input_id}",product_data)
    response = Unirest.patch("http://localhost:3000/products/#{input_id}",parameters: product_data)
    if response.code == 200
      product = Product.new(response.body)
      products_show_view(product)
    elsif response.code == 422
      errors = response.body["errors"]
      products_errors_view(errors)
    elsif response.code == 401
      puts JSON.pretty_generate(response.body)
    end
    
  end

  def products_destroy_action
    system "clear"
    input_id = products_id_form
    #json_data = delete_request("/products/#{input_id}")
    response = Unirest.delete("http://localhost:3000/products/#{input_id}")
    if response.code == 200
      puts response.body["message"]
    elsif response.code == 422
      errors = response.body["errors"]
      products_errors_view(errors)
    elsif response.code == 401
      puts JSON.pretty_generate(response.body)
    end
  end

  def products_search_action
    system "clear"
    print "Enter search term: "
    search_term = gets.chomp
    product_hashs = get_request("products?search=#{search_term}")
    products = Product.convert_hashs(product_hashs)
    products_index_view(products)

  end

  def products_sort_action(attribute)
    product_hashs = get_request("products?sort=#{attribute}")
    products = Product.convert_hashs(product_hashs)
    products_index_view(products)

  end

end