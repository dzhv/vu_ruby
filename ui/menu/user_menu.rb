require_relative('actions/exit_action')
require_relative('actions/show_profile_action')
require_relative('actions/create_auction_action')
require_relative('actions/get_auctions_action')
require_relative('actions/add_money_action')
require_relative('actions/get_all_auctions_action')
require_relative('actions/bid_action')
require_relative('actions/buyout_action')
require_relative('actions/close_action')

# Available actions for a user
class UserMenu < BaseMenu
  def initialize(user_id, user_controller, auction_controller)
    @user_id = user_id
    @user_controller = user_controller
    @auction_controller = auction_controller
    @actions = [ExitAction.new].concat(profile_actions).concat(auction_actions)
  end

  def profile_actions
    [
      ShowProfileAction.new(@user_controller, @user_id),
      GetAuctionsAction.new(@auction_controller, @user_id),
      AddMoneyAction.new(@user_controller, @user_id)
    ]
  end

  def auction_actions
    [
      CreateAuctionAction.new(@auction_controller, @user_id),
      GetAllAuctionsAction.new(@auction_controller),
      BidAction.new(@user_controller, @user_id),
      BuyoutAction.new(@user_controller, @user_id),
      CloseAction.new(@user_controller, @user_id)
    ]
  end

  def show
    puts '----------------------------------------'
    @actions.each_with_index do |action, index|
      puts "#{index} - #{action.name}"
    end
    @actions[read_input].perform
    show
  end
end
