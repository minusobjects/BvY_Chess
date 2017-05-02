class HumanPlayer

  attr_reader :cursor, :color

  def initialize(cursor, color)
    @cursor = cursor
    @color = color
  end

  def play_move
    input = @cursor.get_input
    unless input.nil?
      return input
    end
  end

end
