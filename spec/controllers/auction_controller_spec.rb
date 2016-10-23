require_relative('../../app/controllers/auction_controller')
require_relative('../../app/auction/auction_sale_info')
require_relative('../../app/auction/item')

describe AuctionController do
  let(:auction_controller) { described_class.new('test_auctions.yml') }
  let(:user_controller) do
    UserController.new(
      'test_users.yml',
      'test_auctions.yml',
      'test_logins.yml'
    )
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
  let(:user_id) { user_controller.sign_up(user_data, login_data).id }
  let(:auctions_before) { auction_controller.all_auctions }
  let(:auction) { auction_controller.get_auctions(user_id).first }

  before(:each) do
    auctions_before
    auction_controller.put_auction(user_id, auction_data)
  end

  it 'can request auction creation' do
    expect(auction).to have_attributes(
      user_id: user_id,
      item: Item.new(auction_data[:item]),
      sale_info: AuctionSaleInfo.new(
        auction_data[:starting_price],
        auction_data[:buyout_price]
      )
    )
  end

  it 'can request all auctions' do
    auctions = auction_controller.all_auctions
    expect(auctions).to match_array(auctions_before.concat([auction]))
  end

  it 'can request auction by number' do
    auction_controller.put_auction(user_id, auction_data)
    all_auctions = auction_controller.all_auctions
    expected_auction = all_auctions.last
    actual_auction =
      auction_controller.get_auction_by_number(all_auctions.length - 1)
    expect(actual_auction).to eq(expected_auction)
  end
end
