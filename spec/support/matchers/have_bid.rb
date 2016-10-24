require 'rspec/expectations'
require_relative('../../../app/auction/bid')

RSpec::Matchers.define :have_bid do
  match do |actual_auction|
    actual_auction.sale_info.current_bid != Bid.empty
  end
end
