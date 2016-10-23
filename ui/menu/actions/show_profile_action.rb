require_relative('action')
# Action for showing user profile
class ShowProfileAction < Action
  def initialize(user_controller, user_id)
    @user_controller = user_controller
    @user_id = user_id
    @name = 'View my profile'
  end

  def perform
    user = @user_controller.get_user(@user_id)
    print_contact_info(user.contact_info)
    puts "Balance: #{user.account.balance}"
  end

  def print_contact_info(contact_info)
    puts "Email: #{contact_info.email}"
    puts "Tel. No.: #{contact_info.tel_no}"
    name = contact_info.name
    puts "Name: #{name.first_name}"
    puts "Last name: #{name.last_name}"
  end
end
