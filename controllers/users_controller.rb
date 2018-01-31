module UsersController

  def users_create_action
    user_data = {}
    print "Name: "
    user_data[:name] = gets.chomp
    print "Email: "
    user_data[:email] = gets.chomp
    print "Enter password: "
    user_data[:password] = gets.chomp
    response = Unirest.post("http://localhost:3000/users", parameters: user_data)
    message = response.body
    puts JSON.pretty_generate(message)
  end

end