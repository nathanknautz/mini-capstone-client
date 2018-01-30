module ProductsController

  def products_show_action
    system "clear"
    input_id = products_id_form
    product_hash = get_request("/products/#{input_id}")
    product = Product.new(product_hash)
    products_show_view(product)
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
    json_data = post_request("/products",product_data)
    if !json_data["errors"]
      product = Product.new(json_data)
      products_show_view(product)
    else
      errors = json_data["errors"]
      products_errors_view(errors)
    end
  end

  def products_update_action
    system "clear"
    input_id = products_id_form
    product_hash = get_request("products/#{input_id}")
    product = Product.new(product_hash)
    product_data = products_update_form(product)
    json_data = patch_request("/products/#{input_id}",product_data)
    if !json_data["errors"]
      product = Product.new(json_data)
      products_show_view(product)
    else
      errors = json_data["errors"]
      products_errors_view(errors)
    end
    
  end

  def products_destroy_action
    system "clear"
    input_id = products_id_form
    json_data = delete_request("/products/#{input_id}")
    puts json_data["message"]
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