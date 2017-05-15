require_relative 'steppable.rb'

class Knight < Piece

  include Steppable

  def initialize(color, board, pos)
    super(color, board, pos, "\u2658", :knight)
  end

end

class King < Piece

  include Steppable

  def initialize(color, board, pos)
    super(color, board, pos, "\u2654", :king)
  end

end
