require_relative('bid')
require_relative('../errors/errors')

# User created auction
class Auction
  def initialize(id, user_id, auction_data)
    @id = id
    @user_id = user_id
    @item = Item.new(auction_data[:item])
    @starting_price = auction_data[:starting_price]
    @buyout_price = auction_data[:buyout_price]
    @end_date = auction_data[:end_date]
    @current_bid = Bid.empty
  end

  attr_reader :id
  attr_reader :user_id
  attr_reader :item
  attr_reader :starting_price
  attr_reader :buyout_price
  attr_reader :end_date
  attr_reader :current_bid

  def place_bid(user_id, bid_amount)
    raise Errors.insufficient_bid_amount if bid_amount < current_bid.amount
    @current_bid = Bid.new(user_id, bid_amount)
  end
end
