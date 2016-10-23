require_relative '../spec_helper'
require_relative '../../app/user/user_manager'
require_relative '../../app/user/user'
require_relative '../../app/user/user_repository'
require_relative '../../app/auction/auction_manager'
require_relative '../../app/auction/auction_repository'
require_relative '../../app/authentication/authentication'
require_relative '../../app/authentication/auth_repository'

describe UserManager do
  let(:auction_repository) { AuctionRepository.new('test_auctions.yml') }
  let(:auction_manager) { AuctionManager.new(auction_repository) }
  let(:user_repository) { UserRepository.new('test_users.yml') }
  let(:user_manager) do
    described_class.new(auction_manager, user_repository, authentication)
  end
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

  it 'can sign up a user' do
    user = user_manager.sign_up(user_data, login_data)
    expect(user.contact_info).to have_attributes(
      name: eq(UserName.new(user_data)),
      email: user_data[:email],
      tel_no: user_data[:tel_no]
    )
  end

  it 'creates login data for user' do
    user = user_manager.sign_up(user_data, login_data)
    login = authentication.get_user_login(user.id)
    expect(login).to have_attributes(
      username: login_data[:username],
      password: login_data[:password],
      user_id: user.id
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

  # it 'does not allow to bid with a lower amount' do
  # end

  # it 'does not allow when insufficient funds' do
  # end

  # it 'handles an auction buyout' do
  #   user = first_bidder
  #   user_manager.add_money(user.id, 200)

  #   user_manager.handle_buyout(user.id, auction.id)

  #   expect(user.account.balance).to eq(200 - auction_data[:buyout_price])
  # end
end
