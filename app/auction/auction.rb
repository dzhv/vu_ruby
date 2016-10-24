require_relative('bid')
require_relative('../errors/errors')
require_relative('auction_sale_info')
require_relative('item')
require_relative('../shared/identifier')

# User created auction
class Auction
  def initialize(id, number, user_id, auction_data)
    @identifier = Identifier.new(id, number)
    @user_id = user_id
    @item = Item.new(auction_data[:item])
    @sale_info = AuctionSaleInfo.new(
      auction_data[:starting_price],
      auction_data[:buyout_price]
    )
  end

  attr_reader :identifier
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
    @identifier.id == other.identifier.id
  end

  def active?
    @sale_info.state == 'active'
  end

  def bidded?
    @sale_info.current_bid != Bid.empty
  end

  def close
    raise Errors::NotAllowedError, 'Auction can not be closed' if bidded?
    @sale_info.mark_as_closed
  end
end
