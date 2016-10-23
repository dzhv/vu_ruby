require_relative('../authentication/authentication')
require_relative('../authentication/auth_repository')

# Handles frontend authentication requests
class AuthController
  def initialize(repository_file)
    @authentication = Authentication.new(AuthRepository.new(repository_file))
  end

  def authenticate(username, password)
    @authentication.authenticate(username, password)
  end
end
