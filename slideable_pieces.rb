require_relative 'slideable.rb'

class Rook < Piece

  include Slideable

  def initialize(color, board, pos)
    super(color, board, pos, "\u2656", :rook)
  end

end

class Bishop < Piece

  include Slideable

  def initialize(color, board, pos)
    super(color, board, pos, "\u2657", :bishop)
  end

end

class Queen < Piece

  include Slideable

  def initialize(color, board, pos)
    super(color, board, pos, "\u2655", :queen)
  end

end
