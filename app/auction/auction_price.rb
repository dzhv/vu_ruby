# i created this class because of reek
class AuctionPrice
  def initialize(starting_price, buyout_price)
    @starting_price = starting_price
    @buyout_price = buyout_price
  end

  attr_reader :starting_price
  attr_reader :buyout_price
end
