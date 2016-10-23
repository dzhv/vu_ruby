require_relative 'user_name'

# User contact information
class ContactInformation
  def initialize(user_data)
    @name = UserName.new(user_data)
    @email = user_data[:email]
    @tel_no = user_data[:tel_no]
  end

  attr_reader :name
  attr_reader :email
  attr_reader :tel_no

  def ==(other)
    @name == other.name &&
      @email == other.email &&
      @tel_no == other.tel_no
  end
end
