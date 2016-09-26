# General non-internal user data
class UserGeneralInfo
  def initialize(user_data)
    @name = user_data[:name]
    @surname = user_data[:surname]
    @email = user_data[:email]
    @address = user_data[:address]
    @tel_no = user_data[:tel_no]
  end

  attr_reader :name
  attr_reader :surname
  attr_reader :email
  attr_reader :address
  attr_reader :tel_no
end
