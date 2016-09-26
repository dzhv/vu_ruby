require_relative '../finance/account'
require_relative '../auction/auction'

# Auction system user
class User
  def initialize(id, user_data, auction_manager)
    @id = id
    @name = user_data[:name]
    @surname = user_data[:surname]
    @email = user_data[:email]
    @address = user_data[:address]
    @tel_no = user_data[:tel_no]
    @account = Account.new
    @auction_manager = auction_manager
  end

  attr_reader :id
  attr_reader :name
  attr_reader :surname
  attr_reader :email
  attr_reader :address
  attr_reader :tel_no
  attr_reader :account

  def create_auction(auction_data)
    @auction_manager.create_auction(@id, auction_data)
  end

  def auctions
    @auction_manager.get_auctions(@id)
  end

  def add_money(amount)
    @account.add_money(amount)
  end

  def bid(auction_id, bid_amount)
    @account.withdraw(bid_amount)
    @auction_manager.place_bid(@id, auction_id, bid_amount)
  end
end
