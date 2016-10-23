require_relative '../spec_helper'
require_relative '../../app/auction/auction_manager'
require_relative '../../app/auction/auction_repository'
require('securerandom')

describe AuctionManager do
  let(:auction_repository) { AuctionRepository.new('test_auctions.yml') }
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
      buyout_price: 150
    }
  end
  let(:user1_id) { SecureRandom.uuid }
  let(:user2_id) { SecureRandom.uuid }

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

  context 'when auctions are retrieved' do
    let(:auctions_before) { auction_manager.all_auctions }
    let(:auction1) { auction_manager.create_auction(user1_id, auction_data) }
    let(:auction2) { auction_manager.create_auction(user1_id, auction_data) }
    let(:auction3) { auction_manager.create_auction(user2_id, auction_data) }

    before(:each) do
      auctions_before
      auction1
      auction2
      auction3
    end

    it 'can list user auctions' do
      auctions = auction_manager.get_auctions(user1_id)
      expect(auctions).to eq([auction1, auction2])
    end

    it 'can get all auctions' do
      all_auctions = auction_manager.all_auctions
      expect(all_auctions).to match_array(
        auctions_before.concat([auction1, auction2, auction3])
      )
    end

    it 'can get auction by its number' do
      number_of_auctions = auction_manager.all_auctions.length
      auction = auction_manager.get_auction_by_number(number_of_auctions - 1)
      expect(auction).to eq(auction3)
    end

    it 'does not retrieve bought auctions' do
      auction_manager.buyout_auction(auction1.id)
      expect(auction_manager.all_auctions).not_to include(auction1)
    end
  end
end
