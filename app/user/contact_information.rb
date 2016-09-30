require_relative 'user_name'

# User contact information
class ContactInformation
  def initialize(user_data)
    @name = UserName.new(user_data)
    @email = user_data[:email]
    @address = user_data[:address]
    @tel_no = user_data[:tel_no]
  end

  attr_reader :name
  attr_reader :email
  attr_reader :address
  attr_reader :tel_no
end
