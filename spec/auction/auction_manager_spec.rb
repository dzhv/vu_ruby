require_relative '../spec_helper'
require_relative '../../app/auction/auction_manager'

describe AuctionManager do
  let(:auction_repository) { AuctionRepository.new }
  let(:auction_manager) { described_class.new(auction_repository) }
  let(:item_data) do
    {
      name: 'item',
      description: 'description',
      condition: 9
    }
  end
  let(:auction_data) do
    {
      item: item_data,
      starting_price: 100,
      buyout_price: 150,
      end_date: Date.parse('2016-12-24')
    }
  end
  let(:user1_id) { '1' }
  let(:user2_id) { '2' }

  it 'can list user auctions' do
    auction1 = auction_manager.create_auction(user1_id, auction_data)
    auction2 = auction_manager.create_auction(user1_id, auction_data)
    auction_manager.create_auction(user2_id, auction_data)

    auctions = auction_manager.get_auctions(user1_id)

    expect(auctions).to eq([auction1, auction2])
  end

  it 'can create auction' do
    auction = auction_manager.create_auction(user1_id, auction_data)

    expect(auction).to have_attributes(
      item: Item.new(auction_data[:item]),
      sale_info: AuctionSaleInfo.new(
        auction_data[:starting_price],
        auction_data[:buyout_price]
      )
    )
  end
end
