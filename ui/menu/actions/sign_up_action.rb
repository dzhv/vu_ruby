require 'io/console'
require_relative('action')
# Handles user sign up
class SignUpAction < Action
  def initialize(user_controller)
    @user_controller = user_controller
    @name = 'Sign up'
  end

  def perform
    user_data = read_user_data
    login_data = read_login_data
    @user_controller.sign_up(user_data, login_data)
  end

  def read_user_data
    {
      name: read_value('name'),
      surname: read_value('surname'),
      email: read_value('email'),
      tel_no: read_value('tel_no')
    }
  end

  def read_login_data
    {
      username: read_value('username'),
      password: read_password
    }
  end
end
