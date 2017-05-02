require_relative 'sliding_piece.rb'

class Rook < Piece

  include SlidingPiece

  def initialize(color, board, pos)
    super(color, board, pos, :R, :rook)
  end

end

class Bishop < Piece

  include SlidingPiece

  def initialize(color, board, pos)
    super(color, board, pos, :B, :bishop)
  end

end

class Queen < Piece

  include SlidingPiece

  def initialize(color, board, pos)
    super(color, board, pos, :Q, :queen)
  end

end
