require_relative '../spec_helper'
require_relative '../../app/auction/auction'

describe Auction do
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
  subject(:auction) { Auction.new('id1', 'uid1', auction_data)}

  it 'does not allow lower amount bids' do
    auction.place_bid('uid2', 200)
    expect {
      auction.place_bid('uid3', 150)
    }.to raise_error(Errors.insufficient_bid_amount)
  end
end
