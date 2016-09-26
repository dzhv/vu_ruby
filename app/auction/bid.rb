# user created auction bid
class Bid
  def initialize(user_id, amount)
    @user_id = user_id
    @amount = amount
  end

  def self.empty
    Bid.new('', 0)
  end

  attr_reader :user_id
  attr_reader :amount
end
