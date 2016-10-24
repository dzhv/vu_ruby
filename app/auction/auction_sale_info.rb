# Represents auction sale info
class AuctionSaleInfo
  def initialize(starting_price, buyout_price)
    @starting_price = starting_price
    @buyout_price = buyout_price
    @current_bid = Bid.empty
    @state = 'active'
  end

  attr_reader :starting_price
  attr_reader :buyout_price
  attr_reader :current_bid
  attr_reader :state

  def place_bid(new_bid)
    @current_bid = new_bid
  end

  def mark_as_bought
    @state = 'bought'
    @current_bid = Bid.empty
  end

  def mark_as_closed
    @state = 'closed'
  end

  def ==(other)
    @starting_price == other.starting_price &&
      @buyout_price == other.buyout_price &&
      @current_bid == other.current_bid
  end
end
