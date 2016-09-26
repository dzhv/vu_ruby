# manages auction storages
class AuctionRepository
  def initialize
    @auctions = []
  end

  def get_auctions(user_id)
    @auctions.select { |auct| auct.user_id == user_id }
  end

  def save_auction(auction)
    @auctions.push(auction)
    auction
  end

  def get_auction(auction_id)
    @auctions.find { |auct| auct.id == auction_id }
  end
end
