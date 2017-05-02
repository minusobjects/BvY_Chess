require_relative 'stepping_piece.rb'

class Knight < Piece

  include SteppingPiece

  def initialize(color, board, pos)
    super(color, board, pos, "\u2658", :knight)
  end

end

class King < Piece

  include SteppingPiece

  def initialize(color, board, pos)
    super(color, board, pos, "\u2654", :king)
  end

end
