require 'io/console'
require_relative('../../../app/errors/errors')
require_relative('action')

# Handles user login
class LoginAction < Action
  def initialize(authentication_controller)
    @auth_controller = authentication_controller
    @name = 'Login'
  end

  def perform
    username = read_value('username')
    password = read_password
    return @auth_controller.authenticate(username, password)
  rescue Errors::WrongCredentialsError
    retry_login
  end

  def retry_login
    puts 'Wrong credentials'
    perform
  end
end
