# Represents user login data
class Login
  def initialize(user_id, username, password)
    @user_id = user_id
    @username = username
    @password = password
  end

  attr_reader :user_id
  attr_reader :username
  attr_reader :password

  def ==(other)
    @user_id == other.user_id
  end
end
