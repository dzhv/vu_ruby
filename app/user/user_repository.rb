# User storage class
class UserRepository
  def initialize
    @users = []
  end

  def save_user(user)
    existing = @users.find { |user_entry| user_entry.id == user.id }
    @users.delete(existing)
    @users.push(user)
  end

  def get_user(user_id)
    @users.find { |user| user.id == user_id }
  end
end
