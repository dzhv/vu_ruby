# Avaialble actions for a user
class UserMenu < BaseMenu
  def initialize(user_id, user_controller)
    @user_id = user_id
    @user_controller = user_controller
  end

  def show
    puts '1 - Create auction'
    puts '2 - View my auctions'
    puts '0 - Exit'
    read_input
  end
end
