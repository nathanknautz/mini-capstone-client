module ProductsViews
  def products_show_view(product)
    puts
    puts "#{product.name} - ID: #{product.id}"
    puts 
    puts product.description
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
      puts product.price 
      puts product.tax
      puts "-----------"
      puts product.total
      puts
    end
  end
end