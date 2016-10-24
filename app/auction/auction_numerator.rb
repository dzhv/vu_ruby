# Provides unique numbers for auctions
class AuctionNumerator
  def initialize(auction_repository)
    @auction_repository = auction_repository
  end

  def next_number
    auctions = @auction_repository.all_auctions
    max_number = auctions.collect do |auction|
      auction.identifier.number
    end.max.to_i
    max_number + 1
  end
end
