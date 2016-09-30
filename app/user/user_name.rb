# defines user name
class UserName
  def initialize(user_data)
    @first_name = user_data[:name]
    @last_name = user_data[:surname]
  end

  attr_reader :first_name
  attr_reader :last_name

  def ==(other)
    @first_name == other.first_name &&
      @last_name == other.last_name
  end
end
