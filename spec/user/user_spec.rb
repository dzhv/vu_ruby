require_relative '../spec_helper'
require_relative '../../app/user/user'
require_relative '../../app/finance/account'
require_relative '../../app/auction/auction'
require_relative '../../app/auction/item'
require_relative '../../app/auction/auction_repository'
require('date')

describe User do
  subject(:user_data) {
    {
      name: 'name',
      surname: 'surname',
      email: 'email',
      address: 'address',
      tel_no: 'telephone'
    }
  }
  subject(:auction_repository) { AuctionRepository.new }
  subject(:auction_manager) { AuctionManager.new auction_repository }
  subject(:user_manager) { UserManager.new auction_manager }
  subject(:user) { user_manager.sign_up user_data }
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

  it 'is assigned an account' do
    expect(user.account).to be_a(Account)
  end

  it 'can create auction' do
    auction = user.create_auction(auction_data)
    expect(auction).to be_a(Auction)
  end

  it 'auction data is persisted' do
    auction = user.create_auction(auction_data)
    expect(auction.item).to eq(Item.new(auction_data[:item]))
    expect(auction.starting_price).to eq(auction_data[:starting_price])
    expect(auction.buyout_price).to eq(auction_data[:buyout_price])
    expect(auction.end_date).to eq(auction_data[:end_date])
  end

  it 'can get his auctions' do
    auction1 = user.create_auction(auction_data)
    auction2 = user.create_auction(auction_data)
    auctions = user.auctions

    expect(auctions).to eq([auction1, auction2])
  end

  it 'can add money to account' do
    balance_before_increase = user.account.balance
    amount = 100

    user.add_money(amount)
    expect(user.account.balance - balance_before_increase).to eq(amount)
  end

  it 'can bid on an auction' do
    auction_owner = user_manager.sign_up user_data
    auction = auction_owner.create_auction(auction_data)
    bidder = user
    balance_before_bid = 1000
    bidder.add_money(balance_before_bid)
    bid_amount = 130

    bidder.bid(auction.id, bid_amount)
    auction = auction_manager.get_auction(auction.id)

    expect(bidder.account.balance).to eq(balance_before_bid - bid_amount)
    expect(auction.current_bid.amount).to eq(bid_amount)
    expect(auction.current_bid.user_id).to eq(bidder.id)
  end



end
