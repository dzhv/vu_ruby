require_relative('../authentication/authentication')
require_relative('../authentication/auth_repository')
require_relative('../user/user_manager')
require_relative('../user/user_repository')
require_relative('../auction/auction_repository')
require_relative('../auction/auction_manager')

# Handles frontend-backend calls related to user models
class UserController
  def initialize
    auction_manager = AuctionManager.new(AuctionRepository.new('auctions.yml'))
    authentication = Authentication.new(AuthRepository.new('login.yml'))
    user_repository = UserRepository.new('users.yml')
    @user_manager = UserManager.new(
      auction_manager,
      user_repository,
      authentication
    )
  end

  def sign_up(user_data, login_data)
    @user_manager.sign_up(user_data, login_data)
  end

  def get_user(user_id)
    @user_manager.get_user(user_id)
  end
end
