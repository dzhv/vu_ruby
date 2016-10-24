require_relative '../spec_helper'
require_relative '../../app/user/user_manager'
require_relative '../../app/user/user'
require_relative '../../app/user/user_repository'
require_relative '../../app/auction/auction_manager'
require_relative '../../app/auction/auction_repository'
require_relative '../../app/authentication/authentication'
require_relative '../../app/authentication/auth_repository'
require_relative '../../app/finance/bid_manager'
require_relative '../../app/errors/errors'

describe BidManager do
  let(:auction_repository) { AuctionRepository.new('test_auctions.yml') }
  let(:auction_numerator) { AuctionNumerator.new(auction_repository) }
  let(:auction_manager) do
    AuctionManager.new(auction_repository, auction_numerator)
  end
  let(:user_repository) { UserRepository.new('test_users.yml') }
  let(:user_manager) do
    UserManager.new(auction_manager, user_repository, authentication)
  end
  let(:bid_manager) { described_class.new(user_manager, auction_manager) }
  let(:user_data) do
    {
      name: 'name',
      surname: 'surname',
      email: 'email',
      tel_no: 'telephone'
    }
  end
  let(:login_data) do
    {
      username: 'username',
      password: 'password'
    }
  end
  let(:auction_owner) { user_manager.sign_up(user_data, login_data) }
  let(:first_bidder) { user_manager.sign_up(user_data, login_data) }
  let(:second_bidder) { user_manager.sign_up(user_data, login_data) }
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
  let(:auction) do
    auction_manager.create_auction(auction_owner.id, auction_data)
  end
  let(:authentication) do
    Authentication.new(AuthRepository.new('test_login.yml'))
  end

  before(:each) do
    user_manager.add_money(first_bidder.id, 100)
    user_manager.add_money(second_bidder.id, 200)
    bid_manager.place_bid(first_bidder.id, auction.identifier.id, 50)
  end

  context 'on first auction bid' do
    it 'reduces bidder account balance' do
      bidder = user_manager.get_user(first_bidder.id)
      expect(bidder.account.balance).to eq(50)
    end

    it 'places the bid on auction' do
      bidded_auction = auction_manager.get_auction(auction.identifier.id)
      expect(bidded_auction.sale_info.current_bid).to have_attributes(
        user_id: first_bidder.id,
        amount: 50
      )
    end
  end

  it 'returns money for overthrown bidder' do
    bid_manager.place_bid(second_bidder.id, auction.identifier.id, 200)

    overthrown_bidder = user_manager.get_user(first_bidder.id)
    expect(overthrown_bidder.account.balance).to eq(100)
  end

  context 'on auction buyout' do
    let(:buyer) { second_bidder }
    before(:each) do
      bid_manager.handle_buyout(buyer.id, auction.identifier.id)
    end

    it 'reduces buyer\'s balance' do
      user = user_manager.get_user(buyer.id)
      expect(user.account.balance).to eq(200 - auction_data[:buyout_price])
    end

    it 'marks auction as bought' do
      actual_auction = auction_manager.get_auction(auction.identifier.id)
      expect(actual_auction.sale_info.state).to eq('bought')
    end
  end

  it 'does not allow buyout when insufficient funds' do
    buyer = user_manager.sign_up(user_data, login_data)
    user_manager.add_money(buyer.id, 100)
    expect do
      bid_manager.handle_buyout(buyer.id, auction.identifier.id)
    end.to raise_error(Errors.insufficient_funds)
  end

  context 'on auction close' do
    it 'allows user to close an auction' do
      auction = auction_manager.create_auction(auction_owner.id, auction_data)
      bid_manager.close_auction(auction_owner.id, auction.identifier.id)
      closed_auction = auction_manager.get_auction(auction.identifier.id)
      expect(closed_auction).to be_closed
    end

    it 'does not allow to close other people auctions' do
      user = first_bidder
      expect do
        bid_manager.close_auction(user.id, auction.identifier.id)
      end.to raise_error(Errors::UnauthorizedError)
    end

    it 'does not allow to close a bidded auction' do
      user_manager.add_money(first_bidder.id, 100)
      bid_manager.place_bid(first_bidder.id, auction.identifier.id, 50)
      expect do
        bid_manager.close_auction(auction_owner.id, auction.identifier.id)
      end.to raise_error(Errors::NotAllowedError)
    end
  end
end
