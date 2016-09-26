require_relative '../spec_helper'
require_relative '../../app/auction/auction_manager'

describe AuctionManager do
  subject(:auction_repository) { AuctionRepository.new }
  subject(:auction_manager) { AuctionManager.new(auction_repository) }
  subject(:item_data) {
    {
      name: 'item',
      description: 'description',
      condition: 9
    }
  }
  subject(:auction_data) {
    {
      item: item_data,
      starting_price: 100,
      buyout_price: 150,
      end_date: Date.parse('2016-12-24')
    }
  }

  it 'can list user auctions' do
    user1_id = '1'
    user2_id = '2'
    auction1 = auction_manager.create_auction(user1_id, auction_data)
    auction2 = auction_manager.create_auction(user1_id, auction_data)
    auction_manager.create_auction(user2_id, auction_data)

    auctions = auction_manager.get_auctions(user1_id)

    expect(auctions).to eq([auction1, auction2])
  end

  it 'auction data is persisted' do
    user_id = '1'
    auction = auction_manager.create_auction(user_id, auction_data)
    expect(auction.item).to eq(Item.new(auction_data[:item]))
    expect(auction.price.starting_price).to eq(auction_data[:starting_price])
    expect(auction.price.buyout_price).to eq(auction_data[:buyout_price])
  end
end
