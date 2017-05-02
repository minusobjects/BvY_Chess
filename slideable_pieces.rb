require_relative 'sliding_piece.rb'

class Rook < Piece

  include SlidingPiece

  def initialize(color, board, pos)
    super(color, board, pos, "\u2656", :rook)
  end

end

class Bishop < Piece

  include SlidingPiece

  def initialize(color, board, pos)
    super(color, board, pos, "\u2657", :bishop)
  end

end

class Queen < Piece

  include SlidingPiece

  def initialize(color, board, pos)
    super(color, board, pos, "\u2655", :queen)
  end

end
