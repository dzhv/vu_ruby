require_relative '../spec_helper'
require_relative '../../app/auction/auction'

describe Auction do
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
  let(:auction) { described_class.new('id1', 'uid1', auction_data) }

  it 'does not allow lower amount bids' do
    auction.place_bid('uid2', 200)
    expect do
      auction.place_bid('uid3', 150)
    end.to raise_error(Errors.insufficient_bid_amount)
  end
end
