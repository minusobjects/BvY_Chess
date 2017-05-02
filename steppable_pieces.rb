require_relative 'stepping_piece.rb'
class Knight < Piece

  include SteppingPiece

  def initialize(color, board, pos)
    super(color, board, pos, :K, :knight)
  end

end

class King < Piece

  include SteppingPiece

  def initialize(color, board, pos)
    super(color, board, pos, '@', :king)
  end

end
