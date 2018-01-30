module ProductsViews
  def products_show_view(product)
    puts
    puts "#{product.name} - ID: #{product.id}"
    puts 
    puts "Images"
    puts product.image_urls
    puts 
    puts product.description
    puts
    puts "Supplier: #{product.supplier_name} - Id: #{product.supplier_id}"
    puts
    puts product.price 
    puts product.tax
    puts "-----------"
    puts product.total
  end
  
  def products_index_view(products)
    products.each do |product|
      puts "==================================="
      puts "#{product.name} - ID: #{product.id}"
      puts 
      puts product.description
      puts
      puts "Supplier: #{product.supplier_name} - Id: #{product.supplier_id}"
      puts
      puts product.price 
      puts product.tax
      puts "-----------"
      puts product.total
      puts
    end
  end

  def products_id_form
    print "Enter product ID: "
    gets.chomp
  end

  def products_new_form
    product_data = {}
    print "Name: "
    product_data[:name] = gets.chomp
    print "Price: "
    product_data[:price] = gets.chomp
    print "Image URL: "
    product_data[:image_url] = gets.chomp
    print "Description: "
    product_data[:description] = gets.chomp
    print "Supplier Id: "
    product_data[:supplier_id] = gets.chomp
    product_data
  end

  def products_update_form(product)
    product_data = {}
    print "Name  (#{product.name}): "
    product_data[:name] = gets.chomp
    print "Price  (#{product.price}): "
    product_data[:price] = gets.chomp
    print "Image URL   (#{product.image_url}): "
    product_data[:image_url] = gets.chomp
    print "Description:    (#{product.description}): "
    product_data[:description] = gets.chomp
    print "Supplier Id:   (#{product.supplier_id}): "
    product_data[:supplier_id] = gets.chomp
    product_data.delete_if {|key,value| value.empty?}
    product_data
  end

  def products_errors_view(errors)
    errors.each do |error|
      puts error
    end
  end

end