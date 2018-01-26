module ProductsController

  def products_show_action
    system "clear"
    print "Enter product ID: "
    input_id = gets.chomp
    response = Unirest.get("http://localhost:3000/products/#{input_id}")
    product_hash = response.body 
    product = Product.new(product_hash)
    products_show_view
  end

  def products_index_action
    response = Unirest.get("http://localhost:3000/products/")
    product_hashs = response.body
    products = []
    
    product_hashs.each do |product_hash|
      products << Product.new(product_hash)
    end
    system "clear"
    products_index_view(products)
  end

  def products_create_action
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
  end

  def products_update_action
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
  end

  def products_destroy_action
    system "clear"
    print "Enter product ID: "
    input_id = gets.chomp
    response = Unirest.delete("http://localhost:3000/products/#{input_id}")
    data = response.body
    puts data["message"]
    
  end
end