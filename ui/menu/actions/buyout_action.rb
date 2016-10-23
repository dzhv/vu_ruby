# Action fur buying an auction
class BuyoutAction < Action
  def initialize(user_controller, user_id)
    @user_controller = user_controller
    @user_id = user_id
    @name = 'Buyout auction'
  end

  def perform
    auction_number = read_integer('auction number')
    @user_controller.buyout_auction(auction_number, @user_id)
  end
end
