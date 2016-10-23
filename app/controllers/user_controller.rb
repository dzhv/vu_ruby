require_relative('../authentication/authentication')
require_relative('../authentication/auth_repository')
require_relative('../user/user_manager')
require_relative('../user/user_repository')
require_relative('../auction/auction_repository')
require_relative('../auction/auction_manager')

# Handles frontend-backend calls related to user actions
class UserController
  def initialize(user_file, auction_file, auth_file)
    @auction_manager = AuctionManager.new(AuctionRepository.new(auction_file))
    authentication = Authentication.new(AuthRepository.new(auth_file))
    user_repository = UserRepository.new(user_file)
    @user_manager = UserManager.new(
      @auction_manager,
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

  def add_money(user_id, amount)
    @user_manager.add_money(user_id, amount)
  end

  def place_bid(auction_number, user_id, bid_amount)
    auction_id = @auction_manager.get_auction_by_number(auction_number).id
    @user_manager.place_bid(user_id, auction_id, bid_amount)
  end
end
