# Represents currently logged in user
class UserSession
  def initialize(user_id)
    @user_id = user_id
  end

  attr_reader :user_id

  def self.empty
    UserSession.new('')
  end

  def ==(other)
    @user_id == other.user_id
  end
end
