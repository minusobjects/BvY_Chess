class HumanPlayer

  attr_reader :cursor, :color

  def initialize(cursor, color)
    @cursor = cursor
    @color = color
  end

  def play_move
    get_input
  end

  def choose_piece
    get_input
  end

  def get_input
    input = @cursor.get_input
    unless input.nil?
      return input
    end
  end

end
