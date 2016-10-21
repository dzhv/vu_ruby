require_relative('actions/login_action')
require_relative('base_menu')

# Actions for unsigned user
class LoginMenu < BaseMenu
  def initialize(user_controller, session)
    @actions = [LoginAction.new(user_controller, session)]
  end

  def show
    puts '1 - Login'
    puts '2 - Sign up'
    puts '0 - Exit'
    read_input
  end
end
