# Error messages used in the system
class Errors
  def self.insufficient_funds
    'Insufficient funds'
  end

  def self.insufficient_bid_amount
    'Bid amount was lower then the previouss bid'
  end

  # General exception
  class Error < RuntimeError
  end

  # Not found exception
  class NotFoundError < Error
  end

  # Wrong credentials entered exception
  class WrongCredentialsError < Error
  end
end
