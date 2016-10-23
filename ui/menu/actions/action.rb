# Base class for all actions
class Action
  attr_reader :name

  def read_value(value_name)
    puts "Enter #{value_name}"
    gets.chomp
  end

  def read_integer(field_name)
    puts "Enter #{field_name}"
    return Integer(gets.chomp)
  rescue ArgumentError
    puts 'Value was not an integer, please retry'
    read_integer(field_name)
  end

  def read_float(field_name)
    puts "Enter #{field_name}"
    return Float(gets.chomp)
  rescue ArgumentError
    puts 'Value was not a number, please retry'
    read_float(field_name)
  end

  def read_password
    puts 'Enter password'
    STDIN.noecho(&:gets)
  end
end
