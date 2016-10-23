# Represents auction sale info
class AuctionSaleInfo
  def initialize(starting_price, buyout_price)
    @starting_price = starting_price
    @buyout_price = buyout_price
    @current_bid = Bid.empty
    @bought = false
  end

  attr_reader :starting_price
  attr_reader :buyout_price
  attr_reader :current_bid
  attr_reader :bought

  def place_bid(new_bid)
    @current_bid = new_bid
  end

  def mark_as_bought
    @bought = true
    @current_bid = Bid.empty
  end

  def ==(other)
    @starting_price == other.starting_price &&
      @buyout_price == other.buyout_price &&
      @current_bid == other.current_bid
  end
end
