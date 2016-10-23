require_relative('login')
require_relative('../errors/errors')
require 'digest/sha1'

# handles user authentication
class Authentication
  def initialize(auth_repository)
    @auth_repository = auth_repository
  end

  def create_login(user_id, username, password)
    login = Login.new(user_id, username, Digest::SHA1.hexdigest(password))
    @auth_repository.save_login(login)
  end

  def get_user_login(user_id)
    @auth_repository.get_user_login(user_id)
  end

  def authenticate(username, password)
    login = @auth_repository.get_login(
      username,
      Digest::SHA1.hexdigest(password)
    )
    return login.user_id
  rescue Errors::NotFoundError
    raise Errors::WrongCredentialsError.new, 'Wrong usarname or password'
  end
end
