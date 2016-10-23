# Add money action
class AddMoneyAction < Action
  def initialize(user_controller, user_id)
    @user_controller = user_controller
    @user_id = user_id
    @name = 'Increase account balance'
  end

  def perform
    amount = read_float('amount of money')
    @user_controller.add_money(@user_id, amount)
  end
end
