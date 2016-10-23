require_relative('bid')
require_relative('../errors/errors')
require_relative('auction_sale_info')
require_relative('item')

# User created auction
class Auction
  def initialize(id, user_id, auction_data)
    @id = id
    @user_id = user_id
    @item = Item.new(auction_data[:item])
    @sale_info = AuctionSaleInfo.new(
      auction_data[:starting_price],
      auction_data[:buyout_price]
    )
  end

  attr_reader :id
  attr_reader :user_id
  attr_reader :item
  attr_reader :sale_info

  def place_bid(user_id, bid_amount)
    if bid_amount < sale_info.current_bid.amount
      raise Errors.insufficient_bid_amount
    end
    @sale_info.place_bid(Bid.new(user_id, bid_amount))
  end

  def buyout
    @sale_info.mark_as_bought
  end

  def ==(other)
    @id == other.id
  end
end
