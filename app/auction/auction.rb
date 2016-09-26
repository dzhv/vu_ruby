require_relative('bid')
require_relative('../errors/errors')
require_relative('auction_price')

# User created auction
class Auction
  def initialize(id, user_id, auction_data)
    @id = id
    @user_id = user_id
    @item = Item.new(auction_data[:item])
    @price = AuctionPrice.new(
      auction_data[:starting_price],
      auction_data[:buyout_price]
    )
    @current_bid = Bid.empty
  end

  attr_reader :id
  attr_reader :user_id
  attr_reader :item
  attr_reader :price
  attr_reader :current_bid

  def place_bid(user_id, bid_amount)
    raise Errors.insufficient_bid_amount if bid_amount < current_bid.amount
    @current_bid = Bid.new(user_id, bid_amount)
  end
end
