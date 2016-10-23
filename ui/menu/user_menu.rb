require_relative('actions/exit_action')

# Avaialble actions for a user
class UserMenu < BaseMenu
  def initialize(user_id, user_controller)
    @user_id = user_id
    @user_controller = user_controller
    @actions = [
      ExitAction.new
    ]
  end

  def show
    puts @user_id
    puts '1 - Create auction'
    puts '2 - View my auctions'
    puts '0 - Exit'
    @actions[read_input].perform
  end
end
