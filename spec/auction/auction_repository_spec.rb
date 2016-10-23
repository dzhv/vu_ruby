require_relative('../../app/auction/auction_repository')

describe AuctionRepository do
  let(:file_name) { 'test_auctions.yml' }
  let(:repository) { described_class.new(file_name) }
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
  let(:user_id) { '0' }
  let(:auction) { Auction.new('0', user_id, auction_data) }

  before(:each) do
    File.delete(file_name) if File.exist?(file_name)
    repository.save_auction(auction)
  end

  it 'creates a file when it does not exist' do
    expect(File.exist?(file_name)).to be true
  end

  it 'saves data externally' do
    repository = described_class.new(file_name)
    expect(repository.get_auctions(user_id)).not_to be_empty
  end
end
