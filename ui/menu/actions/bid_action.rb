# Action for bidding on an auction
class BidAction < Action
  def initialize(user_controller, user_id)
    @user_controller = user_controller
    @user_id = user_id
    @name = 'Place bid on an auction'
  end

  def perform
    auction_number = read_integer('auction number')
    bid_amount = read_float('bid amount')
    @user_controller.place_bid(auction_number, @user_id, bid_amount)
  end
end
