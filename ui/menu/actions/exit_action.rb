require_relative('action')
# Action for stopping program execution
class ExitAction < Action
  def initialize
    @name = 'Exit'
  end

  def perform
    exit
  end
end
