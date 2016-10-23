require_relative('../../app/controllers/auction_controller')
require_relative('../../app/auction/auction_sale_info')
require_relative('../../app/auction/item')

describe AuctionController do
  let(:auction_controller) { described_class.new }
  let(:user_controller) { UserController.new }
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

  it 'can handle auction creation' do
    user_id = user_controller.sign_up(user_data, login_data).id
    auction_controller.put_auction(user_id, auction_data)
    auctions = auction_controller.get_auctions(user_id)
    expect(auctions.first).to have_attributes(
      user_id: user_id,
      item: Item.new(auction_data[:item]),
      sale_info: AuctionSaleInfo.new(
        auction_data[:starting_price],
        auction_data[:buyout_price]
      )
    )
  end
end
