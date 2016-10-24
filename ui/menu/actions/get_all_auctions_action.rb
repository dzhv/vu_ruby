require_relative('action')
# Action for getting all auctions
class GetAllAuctionsAction < Action
  def initialize(auction_controller)
    @auction_controller = auction_controller
    @name = 'View all auctions'
  end

  def perform
    auctions = @auction_controller.all_auctions
    auctions.each { |auction| print_auction(auction) }
  end

  def print_auction(auction)
    puts '----------------------------------------'
    puts "Auction ##{auction.identifier.number}: "
    print_auction_data(auction)
  end

  def print_auction_data(auction)
    print_item_data(auction.item)
    print_sale_info(auction.sale_info)
  end

  def print_item_data(item)
    puts 'Item: '
    puts "  Name: #{item.name}"
    puts "  Descripton: #{item.description}"
    puts "  Condition: #{item.condition}"
  end

  def print_sale_info(sale_info)
    puts "Starting price: #{sale_info.starting_price}"
    puts "Buyout price: #{sale_info.buyout_price}"
    puts "Current bid: #{sale_info.current_bid.amount}"
  end
end
