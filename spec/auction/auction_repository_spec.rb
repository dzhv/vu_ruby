require_relative('../../app/auction/auction_repository')

describe AuctionRepository do
  let(:prepared_file) { 'test_auction_load.yml' }
  let(:output_file) { 'test_auctions_output.yml' }
  let(:item1_data) do
    {
      name: 'Bike',
      description: 'rideable',
      condition: 9
    }
  end
  let(:auction1_data) do
    {
      id: '19463997-0124-4ec7-a9f9-7c8d71dba55b',
      number: 2,
      user_id: '2c9c7e80-86eb-41e5-90af-87c9a9c0f6d8',
      item: item1_data,
      starting_price: 100,
      buyout_price: 150,
      bid_user_id: '0c2e5e64-cbef-4209-be27-24a3fcd58d4e',
      bid_amount: 50
    }
  end
  let(:auction1) do
    auction = Auction.new(
      auction1_data[:id],
      auction1_data[:number],
      auction1_data[:user_id],
      auction1_data
    )
    auction.place_bid(auction1_data[:bid_user_id], auction1_data[:bid_amount])
    auction
  end
  let(:item2_data) do
    {
      name: 'Ball',
      description: 'bouncy',
      condition: 5
    }
  end
  let(:auction2_data) do
    {
      id: '0d7ce1b3-4aae-44b2-92a7-b4e3d1e9eadc',
      number: 3,
      user_id: '0c2e5e64-cbef-4209-be27-24a3fcd58d4e',
      item: item2_data,
      starting_price: 111,
      buyout_price: 123,
      bid_user_id: '2c9c7e80-86eb-41e5-90af-87c9a9c0f6d8',
      bid_amount: 55
    }
  end
  let(:auction2) do
    auction = Auction.new(
      auction2_data[:id],
      auction2_data[:number],
      auction2_data[:user_id],
      auction2_data
    )
    auction.place_bid(auction2_data[:bid_user_id], auction2_data[:bid_amount])
    auction
  end

  before(:each) do
    File.delete(output_file) if File.exist?(output_file)
  end

  it 'creates a file when it does not exist' do
    repository = described_class.new(output_file)
    repository.save_auction(auction1)
    expect(File.exist?(output_file)).to be true
  end

  it 'loads data from a file' do
    repository = described_class.new(prepared_file)
    expect(repository.all_auctions).to match_array([auction1, auction2])
  end

  it 'saves data to a file' do
    repository = described_class.new(output_file)
    repository.save_auction(auction1)
    repository.save_auction(auction2)

    prepared_data = IO.read(prepared_file)
    actual_data = IO.read(output_file)
    expect(actual_data).to eq(prepared_data)
  end
end
