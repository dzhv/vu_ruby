require_relative('user')
require 'securerandom'
require_relative('../errors/errors')

# manages actions with system users
class UserManager
  def initialize(auction_manager, user_repository, authentication)
    @auction_manager = auction_manager
    @user_repository = user_repository
    @authentication = authentication
  end

  def sign_up(user_data, login_data)
    id = SecureRandom.uuid
    user = User.new(id, user_data)
    @authentication.create_login(
      user.id,
      login_data[:username],
      login_data[:password]
    )
    @user_repository.save_user(user)
  end

  def get_user(user_id)
    @user_repository.get_user(user_id)
  end

  def add_money(user_id, amount)
    user = get_user(user_id)
    user.add_money(amount)
    @user_repository.save_user(user)
  end

  def save_user(user)
    @user_repository.save_user(user)
  end
end
