require_relative('../auction/auction_repository')
require_relative('../auction/auction_manager')

# Handles frontend-backend calls related to auctions
class AuctionController
  def initialize
    @auction_manager = AuctionManager.new(AuctionRepository.new('auctions.yml'))
  end

  def put_auction(user_id, auction_data)
    @auction_manager.create_auction(user_id, auction_data)
  end

  def get_auctions(user_id)
    @auction_manager.get_auctions(user_id)
  end
end
