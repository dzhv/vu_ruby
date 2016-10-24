require_relative('../authentication/authentication')
require_relative('../authentication/auth_repository')
require_relative('../user/user_manager')
require_relative('../user/user_repository')
require_relative('../auction/auction_repository')
require_relative('../auction/auction_manager')
require_relative('../finance/bid_manager')

# Handles frontend-backend calls related to user actions
class UserController
  def initialize(user_file, auction_file, auth_file)
    auction_repository = AuctionRepository.new(auction_file)
    @auction_manager = AuctionManager.new(
      auction_repository,
      AuctionNumerator.new(auction_repository)
    )
    @user_manager = construct_user_manager(user_file, auth_file)
    @bid_manager = BidManager.new(@user_manager, @auction_manager)
  end

  def construct_user_manager(user_file, auth_file)
    UserManager.new(
      @auction_manager,
      UserRepository.new(user_file),
      Authentication.new(AuthRepository.new(auth_file))
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
    auction = @auction_manager.get_auction_by_number(auction_number)
    auction_id = auction.identifier.id
    @bid_manager.place_bid(user_id, auction_id, bid_amount)
  end

  def buyout_auction(number, user_id)
    auction = @auction_manager.get_auction_by_number(number)
    auction_id = auction.identifier.id
    @bid_manager.handle_buyout(user_id, auction_id)
  end

  def close_auction(number, user_id)
    auction = @auction_manager.get_auction_by_number(number)
    auction_id = auction.identifier.id
    @bid_manager.close_auction(user_id, auction_id)
  end
end
