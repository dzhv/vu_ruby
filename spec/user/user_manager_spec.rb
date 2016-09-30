require_relative '../spec_helper'
require_relative '../../app/user/user_manager'
require_relative '../../app/user/user'
require_relative '../../app/user/user_repository'
require_relative '../../app/auction/auction_manager'
require_relative '../../app/auction/auction_repository'

describe UserManager do
  let(:auction_repository) { AuctionRepository.new }
  let(:auction_manager) { AuctionManager.new(auction_repository) }
  let(:user_repository) { UserRepository.new }
  let(:user_manager) { described_class.new(auction_manager, user_repository) }
  let(:user_data) do
    {
      name: 'name',
      surname: 'surname',
      email: 'email',
      address: 'address',
      tel_no: 'telephone'
    }
  end
  let(:auction_owner) { user_manager.sign_up(user_data) }
  let(:first_bidder) { user_manager.sign_up(user_data) }
  let(:second_bidder) { user_manager.sign_up(user_data) }
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
  let(:auction) do
    auction_manager.create_auction(auction_owner.id, auction_data)
  end

  it 'can sign up a user' do
    user = user_manager.sign_up(user_data)
    expect(user.contact_info).to have_attributes(
      name: eq(UserName.new(user_data)),
      email: user_data[:email],
      address: user_data[:address],
      tel_no: user_data[:tel_no]
    )
  end

  before(:each) do
    user_manager.add_money(first_bidder.id, 100)
    user_manager.add_money(second_bidder.id, 200)
    user_manager.place_bid(first_bidder.id, auction.id, 50)
  end

  context 'on first auction bid' do
    it 'reduces bidder account balance' do
      bidder = user_manager.get_user(first_bidder.id)
      expect(bidder.account.balance).to eq(50)
    end

    it 'places the bid on auction' do
      bidded_auction = auction_manager.get_auction(auction.id)
      expect(bidded_auction.sale_info.current_bid).to have_attributes(
        user_id: first_bidder.id,
        amount: 50
      )
    end
  end

  it 'returns money for overthrown bidder' do
    user_manager.add_money(second_bidder.id, 200)

    user_manager.place_bid(second_bidder.id, auction.id, 200)

    overthrown_bidder = user_manager.get_user(first_bidder.id)
    expect(overthrown_bidder.account.balance).to eq(100)
  end
end
