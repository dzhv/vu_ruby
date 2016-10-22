require 'io/console'
require_relative('../../../app/errors/errors')

# Handles user login
class LoginAction
  def initialize(authentication_controller)
    @auth_controller = authentication_controller
  end

  def perform
    username = read_username
    password = read_password
    return @auth_controller.authenticate(username, password)
  rescue Errors::WrongCredentialsError
    retry_login
  end

  def retry_login
    puts 'Wrong credentials'
    perform
  end

  def read_username
    puts 'Enter username'
    gets.chomp
  end

  def read_password
    puts 'Enter password'
    STDIN.noecho(&:gets)
  end
end
