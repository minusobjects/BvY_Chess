require 'singleton'

class NullPiece
  include Singleton
  attr_reader :symbol, :color, :type

  def initialize
    @symbol = :+
    @color = :light_white
    @type = :null
  end

  def moves
    []
  end

  def type
    'null'
  end

  def to_s
    @symbol.to_s
  end

end
