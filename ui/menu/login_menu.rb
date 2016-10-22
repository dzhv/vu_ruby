require_relative('actions/login_action')
require_relative('base_menu')

# Actions for unsigned user
class LoginMenu < BaseMenu
  def initialize(authentication_controller, session)
    @actions = [LoginAction.new(authentication_controller, session)]
  end

  def show
    puts '1 - Login'
    puts '2 - Sign up'
    puts '0 - Exit'
    @actions[read_input - 1].perform
  end
end
