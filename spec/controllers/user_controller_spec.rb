require_relative('../../app/controllers/user_controller')
require_relative('../../app/controllers/auction_controller')
require_relative('../../app/user/contact_information')
require('securerandom')

describe UserController do
  let(:user_controller) do
    described_class.new(
      'test_users.yml',
      'test_auctions.yml',
      'test_logins.yml'
    )
  end
  let(:auction_controller) { AuctionController.new('test_auctions.yml') }
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
      username: SecureRandom.uuid,
      password: SecureRandom.uuid
    }
  end
  let(:user) { user_controller.sign_up(user_data, login_data) }
  let(:increase_amount) { 200 }
  before(:each) do
    user_controller.add_money(user.id, increase_amount)
    auction_controller.put_auction(user.id, auction_data)
    auction_controller.put_auction(user.id, auction_data)
  end

  it 'allows user to get his profile' do
    actual_user = user_controller.get_user(user.id)
    expect(actual_user).to have_attributes(
      id: user.id,
      contact_info: ContactInformation.new(user_data)
    )
  end

  it 'initiates user account balance increase' do
    initial_balance = user.account.balance
    incrased_user = user_controller.get_user(user.id)
    expect(incrased_user.account.balance).to eq(
      initial_balance + increase_amount
    )
  end

  it 'initiates bid placement' do
    auction_number = auction_controller.all_auctions.first.identifier.number
    user_controller.place_bid(auction_number, user.id, 100)
    auction = auction_controller.get_auction_by_number(auction_number)
    expect(auction.sale_info.current_bid).to have_attributes(
      user_id: user.id,
      amount: 100
    )
  end

  it 'initiates buyout' do
    auction_number = auction_controller.all_auctions.first.identifier.number
    auction = auction_controller.get_auction_by_number(auction_number)
    user_controller.buyout_auction(auction_number, user.id)
    expect(auction_controller.all_auctions).not_to include(auction)
  end

  it 'initiates auction close' do
    auction_number = auction_controller.all_auctions.last.identifier.number
    user_controller.close_auction(auction_number, user.id)
    auction = auction_controller.get_auction_by_number(auction_number)
    expect(auction.active?).to be false
  end
end
