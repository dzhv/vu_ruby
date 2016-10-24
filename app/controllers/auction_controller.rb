require_relative('../auction/auction_repository')
require_relative('../auction/auction_manager')
require_relative('../auction/auction_numerator')

# Handles frontend-backend calls related to auctions
class AuctionController
  def initialize(repository_file)
    auction_repository = AuctionRepository.new(repository_file)
    auction_numerator = AuctionNumerator.new(auction_repository)
    @auction_manager = AuctionManager.new(
      auction_repository,
      auction_numerator
    )
  end

  def put_auction(user_id, auction_data)
    @auction_manager.create_auction(user_id, auction_data)
  end

  def get_auctions(user_id)
    @auction_manager.get_auctions(user_id)
  end

  def all_auctions
    @auction_manager.all_auctions
  end

  def get_auction_by_number(number)
    @auction_manager.get_auction_by_number(number)
  end
end
