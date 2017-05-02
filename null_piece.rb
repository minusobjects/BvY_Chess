require 'singleton'

class NullPiece
  include Singleton
  attr_reader :symbol, :color

  def initialize
    @symbol = :+
    @color = :light_white
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
