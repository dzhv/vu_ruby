require('yaml')

# Auction storage class
class AuctionRepository
  def initialize(file_name)
    @file_name = file_name
  end

  def get_auctions(user_id)
    all_auctions.select { |auct| auct.user_id == user_id }
  end

  def save_auction(auction)
    auctions = all_auctions
    auctions.delete(auction)
    File.open(@file_name, 'w') do |file|
      file.write(auctions.push(auction).to_yaml)
    end
    auction
  end

  def get_auction(auction_id)
    all_auctions.find { |auct| auct.id == auction_id }
  end

  def all_auctions
    ensure_file_exists
    File.open(@file_name, 'r') do |file|
      YAML.load(file)
    end || []
  end

  def ensure_file_exists
    File.open(@file_name, 'w') {} unless File.exist?(@file_name)
  end
end
