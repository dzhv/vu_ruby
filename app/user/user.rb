require_relative '../finance/account'
require_relative '../auction/auction'
require_relative 'user_general_info'

# Auction system user
class User
  def initialize(id, user_data)
    @id = id
    @general_info = UserGeneralInfo.new(user_data)
    @account = Account.new
  end

  attr_reader :id
  attr_reader :general_info
  attr_reader :account

  def add_money(amount)
    @account.add_money(amount)
  end

  def withdraw_money(amount)
    @account.withdraw(amount)
  end
end
