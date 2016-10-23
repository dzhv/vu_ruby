require_relative('actions/login_action')
require_relative('actions/sign_up_action')
require_relative('base_menu')

# Actions for unsigned user
class LoginMenu < BaseMenu
  def initialize(authentication_controller, user_controller)
    @actions = [
      -> { exit },
      -> { login },
      -> { sign_up }
    ]
    @login_action = LoginAction.new(authentication_controller)
    @sign_up_action = SignUpAction.new(user_controller)
  end

  def show
    puts '1 - Login'
    puts '2 - Sign up'
    puts '0 - Exit'
    @actions[read_input].call
  end

  def login
    @login_action.perform
  end

  def sign_up
    @sign_up_action.perform
    show
  end
end
