require_relative('menu/login_menu')
require_relative('user_session')
require_relative('controllers/user_controller')

# Controlls all the UI
class UI
  def initialize
    @session = UserSession.empty
    @current_menu = LoginMenu.new(UserController.new, @session)
  end

  def start_ui
    @current_menu.show
  end

  def user_is_logged_in
    !@session == UserSession.empty
  end
end
