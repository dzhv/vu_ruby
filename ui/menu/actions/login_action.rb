# Handles user login
class LoginAction
  def initialize(user_controller, user_session)
    @user_controller = user_controller
    @user_session = user_session
  end

  def perform
  end
end
