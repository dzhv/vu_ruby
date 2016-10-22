require_relative('menu/login_menu')
require_relative('menu/user_menu')
require_relative('user_session')
require_relative('../app/controllers/user_controller')
require_relative('../app/controllers/authentication_controller')

# Controlls all the UI
class UI
  def initialize
    @session = UserSession.empty
  end

  def start_ui
    login
    user_menu = UserMenu.new(@session.user_id, UserController.new)
    user_menu.show
  end

  def login
    login_menu = LoginMenu.new(AuthController.new, @session)
    user_id = login_menu.show
    @session = UserSession.new(user_id)
  end

  def user_is_logged_in
    @session != UserSession.empty
  end
end
