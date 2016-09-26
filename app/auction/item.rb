# item which is being sold in an auction
class Item
  def initialize(item_data)
    @name = item_data[:name]
    @description = item_data[:description]
    @condition = item_data[:condition]
  end

  attr_reader :name
  attr_reader :description
  attr_reader :condition

  def ==(other)
    name == other.name &&
      description == other.description &&
      condition == other.condition
  end
end
