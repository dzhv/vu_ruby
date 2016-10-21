require_relative('login')

# handles user authentication
class Authentication
  def initialize(auth_repository)
    @auth_repository = auth_repository
  end

  def create_login(user, username, password)
    login = Login.new(user.id, username, password)
    @auth_repository.save_login(login)
  end

  def get_login(user_id)
    @auth_repository.get_login(user_id)
  end
end
