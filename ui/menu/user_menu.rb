require_relative('actions/exit_action')
require_relative('actions/show_profile_action')
require_relative('actions/create_auction_action')

# Available actions for a user
class UserMenu < BaseMenu
  def initialize(user_id, user_controller, auction_controller)
    @user_id = user_id
    @actions = [
      ExitAction.new,
      ShowProfileAction.new(user_controller, @user_id),
      CreateAuctionAction.new(auction_controller, @user_id)
    ]
  end

  def show
    # puts '2 - View my auctions'
    puts '1 - View my profile'
    puts '2 - Create auction'
    puts '0 - Exit'
    @actions[read_input].perform
    show
  end
end
