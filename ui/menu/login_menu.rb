require_relative('actions/login_action')
require_relative('actions/sign_up_action')
require_relative('base_menu')

# Actions for unsigned user
class LoginMenu < BaseMenu
  def initialize(authentication_controller, user_controller)
    @actions = [
      -> { exit },
      -> { login(authentication_controller) },
      -> { sign_up(user_controller) }
    ]
  end

  def show
    puts '1 - Login'
    puts '2 - Sign up'
    puts '0 - Exit'
    @actions[read_input].call
  end

  def login(authentication_controller)
    LoginAction.new(authentication_controller).perform
  end

  def sign_up(user_controller)
    SignUpAction.new(user_controller).perform
    show
  end
end
