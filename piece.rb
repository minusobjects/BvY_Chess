class Piece

  attr_reader :symbol, :color, :type, :board
  attr_accessor :pos

  def initialize(color, board, pos, symbol, type)
    @color = color
    @board = board
    @pos = pos
    @symbol = symbol
    @type = type
  end

  def to_s
    @symbol.to_s.colorize(color)
  end
  
end
