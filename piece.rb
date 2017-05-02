require_relative 'sliding_piece.rb'
require 'colorize'

class Piece

  attr_reader :symbol, :color, :pos, :type, :board

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

  def valid_move?(start_pos, end_pos)
    true
  end

end
