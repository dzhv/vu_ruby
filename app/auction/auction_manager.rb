require_relative('auction')
require_relative('../errors/errors')
require 'securerandom'

# manages actions with system auctions
class AuctionManager
  def initialize(auction_repository, auction_numerator)
    @auction_repository = auction_repository
    @auction_numerator = auction_numerator
  end

  def get_auctions(user_id)
    @auction_repository.get_auctions(user_id)
  end

  def create_auction(user_id, auction_data)
    id = SecureRandom.uuid
    number = @auction_numerator.next_number
    auction = Auction.new(id, number, user_id, auction_data)
    @auction_repository.save_auction(auction)
  end

  def get_auction(auction_id)
    @auction_repository.get_auction(auction_id)
  end

  def all_auctions
    @auction_repository.all_open_auctions
  end

  def place_bid(user_id, auction_id, bid_amount)
    auction = get_auction(auction_id)
    auction.place_bid(user_id, bid_amount)
    @auction_repository.save_auction(auction)
  end

  def get_auction_by_number(number)
    @auction_repository.get_auction_by_number(number)
  end

  def buyout_auction(auction_id)
    auction = get_auction(auction_id)
    auction.buyout
    @auction_repository.save_auction(auction)
  end

  def close_auction(user_id, auction_id)
    auction = get_auction(auction_id)
    if auction.user_id != user_id
      raise Errors::UnauthorizedError.new, 'Not allowed'
    end
    auction.close
    @auction_repository.save_auction(auction)
  end
end
