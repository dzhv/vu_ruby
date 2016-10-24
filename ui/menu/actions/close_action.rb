# Action for closing auctions
class CloseAction < Action
  def initialize(user_controller, user_id)
    @user_controller = user_controller
    @user_id = user_id
    @name = 'Close auction'
  end

  def perform
    auction_number = read_integer('auction number')
    @user_controller.close_auction(auction_number, @user_id)
  end
end
