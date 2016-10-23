# Action for creating an auction
class CreateAuctionAction < Action
  def initialize(auction_controller, user_id)
    @auction_controller = auction_controller
    @user_id = user_id
    @name = 'Create auction'
  end

  def perform
    auction_data = {
      item: read_item_data,
      starting_price: read_float('starting price'),
      buyout_price: read_float('buyout price')
    }
    @auction_controller.put_auction(@user_id, auction_data)
  end

  def read_item_data
    {
      name: read_value('item name'),
      description: read_value('item description'),
      condition: read_integer('condition')
    }
  end

  # def read_date(field_name)
  #   puts "Enter #{field_name}"
  #   return Date.parse(gets.chomp)
  # rescue ArgumentError
  #   puts "Value was not a date, please retry"
  #   read_date
  # end
end
