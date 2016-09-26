require_relative '../spec_helper'
require_relative '../../app/user/user_manager'
require_relative '../../app/user/user'
require_relative '../../app/user/user_repository'
require_relative '../../app/auction/auction_manager'
require_relative '../../app/auction/auction_repository'

describe UserManager do
  subject(:auction_repository) { AuctionRepository.new }
  subject(:auction_manager) { AuctionManager.new(auction_repository) }
  subject(:user_repository) { UserRepository.new }
  subject(:user_manager) { UserManager.new(auction_manager, user_repository) }
  subject(:user_data) {
    {
      name: 'name',
      surname: 'surname',
      email: 'email',
      address: 'address',
      tel_no: 'telephone'
    }
  }
  subject(:user) { user_manager.sign_up(user_data) }
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

  it 'sign up data is persisted' do
    info = user.general_info
    expect(info.name).to equal(user_data[:name])
    expect(info.surname).to equal(user_data[:surname])
    expect(info.email).to equal(user_data[:email])
    expect(info.address).to equal(user_data[:address])
    expect(info.tel_no).to equal(user_data[:tel_no])
  end

  it 'can handle user bid' do
    auction_owner = user_manager.sign_up user_data
    bidder = user_manager.sign_up user_data
    user_manager.add_money(bidder.id, 100)
    auction = auction_manager.create_auction(auction_owner.id, auction_data)

    user_manager.place_bid(bidder.id, auction.id, 50)

    bidder = user_manager.get_user(bidder.id)
    auction = auction_manager.get_auction(auction.id)
    expect(bidder.account.balance).to eq(50)
    expect(auction.current_bid.user_id).to eq(bidder.id)
    expect(auction.current_bid.amount).to eq(50)
  end

  it 'returns money for overthrown bidder' do
    first_bidder = user_manager.sign_up user_data
    second_bidder = user
    user_manager.add_money(first_bidder.id, 100)
    user_manager.add_money(second_bidder.id, 200)

    auction = auction_manager.create_auction('', auction_data)
    user_manager.place_bid(first_bidder.id, auction.id, 100)
    user_manager.place_bid(second_bidder.id, auction.id, 200)

    first_bidder = user_manager.get_user(first_bidder.id)
    second_bidder = user_manager.get_user(second_bidder.id)

    expect(first_bidder.account.balance).to eq(100)
    expect(second_bidder.account.balance).to eq(0)
  end
end
