# Functionality common between all menus
class BaseMenu
  def initialize
    @actions = []
  end

  def validate_input(input)
    input_is_valid = input_is_valid(input)
    repeat_read unless input_is_valid
    actions[Integer(input)] if input_is_valid
  end

  def repeat_read
    puts 'Invalid input'
    read_input
  end

  def read_input
    input = gets.chomp
    validate_input(input)
  end

  def input_is_valid(input)
    (0..@actions.length).cover?(Integer(input))
  end
end
