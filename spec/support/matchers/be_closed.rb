require 'rspec/expectations'

RSpec::Matchers.define :be_closed do
  match do |auction|
    auction.sale_info.state == 'closed'
  end
end
