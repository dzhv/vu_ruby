require_relative 'user'
require 'securerandom'

# manages actionss with system users
class UserManager
  def initialize(auction_manager, user_repository, authentication)
    @auction_manager = auction_manager
    @user_repository = user_repository
    @authentication = authentication
  end

  def sign_up(user_data, login_data)
    id = SecureRandom.uuid
    user = User.new(id, user_data)
    @authentication.create_login(
      user,
      login_data[:username],
      login_data[:password]
    )
    @user_repository.save_user(user)
  end

  def get_user(user_id)
    @user_repository.get_user(user_id)
  end

  def add_money(user_id, amount)
    user = get_user(user_id)
    user.add_money(amount)
    @user_repository.save_user(user)
  end

  def place_bid(user_id, auction_id, amount)
    user = get_user(user_id)
    raise Error.insufficient_funds if amount > user.account.balance
    auction = @auction_manager.get_auction(auction_id)
    handle_bid_transactions(user, auction, amount)
  end

  def handle_bid_transactions(user, auction, bid_amount)
    current_bid = auction.sale_info.current_bid
    @auction_manager.place_bid(user.id, auction.id, bid_amount)
    handle_user_finances(current_bid, user, bid_amount)
  end

  def handle_user_finances(previous_bid, bidder, bid_amount)
    bidder.withdraw_money(bid_amount)
    save_user(bidder)
    refund_overthrown_bidder(previous_bid) unless previous_bid == Bid.empty
  end

  def refund_overthrown_bidder(overthrown_bid)
    overthrown_bidder = get_user(overthrown_bid.user_id)
    overthrown_bidder.add_money(overthrown_bid.amount)
    save_user(overthrown_bidder)
  end

  def save_user(user)
    @user_repository.save_user(user)
  end
end
