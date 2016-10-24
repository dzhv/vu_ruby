# Auction identifying information
class Identifier
  def initialize(id, number)
    @id = id
    @number = number
  end

  attr_reader :id
  attr_reader :number
end
