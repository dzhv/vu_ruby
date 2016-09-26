require_relative 'user'
require 'securerandom'

# manages actionss with system users
class UserManager
  def initialize(auction_manager)
    @auction_manager = auction_manager
  end

  def sign_up(user_data)
    id = SecureRandom.uuid
    User.new(id, user_data, @auction_manager)
  end
end
