class SessionsView
  def ask_username
    puts "Username?"
    gets.chomp
  end

  def ask_password
    puts "Password?"
    gets.chomp
  end

  def wrong_credentials
    puts "Wrong Credentials... try again"
  end

  def welcome(username)
    puts "Welcome to food delivery #{username}"
  end
end
