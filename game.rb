require_relative 'board.rb'
require_relative 'human_player.rb'
require_relative 'display.rb'

class Game

  attr_reader :board

  def initialize
    @board = Board.new
  end

end
