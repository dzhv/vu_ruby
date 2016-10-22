require_relative('../authentication/authentication')
require_relative('../authentication/auth_repository')

# Handles frontend authentication requests
class AuthController
  def initialize
    @file_name = 'login.yml'
    @authentication = Authentication.new(AuthRepository.new(@file_name))
  end

  def authenticate(username, password)
    @authentication.authenticate(username, password)
  end
end
