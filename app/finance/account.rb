require_relative '../errors/errors'
# user's system account
class Account
  def initialize
    @balance = 0
  end

  attr_reader :balance

  def add_money(amount)
    @balance += amount
  end

  def withdraw(amount)
    raise Errors.insufficient_funds if amount > @balance
    @balance -= amount
  end
end
