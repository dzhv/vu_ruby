require 'io/console'

# Handles user sign up
class SignUpAction
  def initialize(user_controller)
    @user_controller = user_controller
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

  def read_value(value_name)
    puts "Enter #{value_name}:"
    gets.chomp
  end

  def read_password
    puts 'Enter password'
    STDIN.noecho(&:gets)
  end
end
