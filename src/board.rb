require_relative 'piece.rb'
require_relative 'null_piece.rb'
require_relative 'slideable_pieces.rb'
require_relative 'steppable_pieces.rb'
require_relative 'pawn.rb'

class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    setup_board
  end

  def [](x,y)
    @grid[y][x]
  end

  def []=(pos, value)
    x = pos[0]
    y = pos[1]
    @grid[y][x] = value
  end

  def move_piece(start_pos, end_pos) # enter pos [x,y]
    start_x, start_y = start_pos
    end_x, end_y = end_pos

    piece = @grid[start_y][start_x]
    coords = [start_x, start_y, end_x, end_y]
    raise 'Illegal move!' unless possible_move?(piece, coords)

    @grid[end_y][end_x] = piece
    piece.pos = [end_x, end_y]
    @grid[start_y][start_x] = NullPiece.instance
  end

  def in_check?(color)
    king_pos = king_positions[color]
    @grid.each_with_index do |row, r|
      row.each_with_index do |col, c|
        if @grid[r][c].color == opposing_color(color) &&
          @grid[r][c].moves.include?(king_pos)
            return true
        end
      end
    end
    return false
  end

  def check_moves(piece)
    # creates an array of invalid (check) moves for the given piece
    result = []
    piece.moves.each do |move|
      coords = [piece.pos[0], piece.pos[1], move[0], move[1]]
      prev_piece = @grid[coords[3]][coords[2]]
      test_move(coords, piece)
      if in_check?(piece.color) == true
        result << [move[0], move[1]]
      end
      reset_move(coords, piece, prev_piece)
    end
    result
  end

  def puts_color_in_check?(coords, color)
    answer = :no
    piece = @grid[coords[1]][coords[0]]
    prev_piece = @grid[coords[3]][coords[2]]
    test_move(coords, piece)
    if in_check?(color)
      answer = :mate if checkmate?(color)
      answer = :check
    end
    reset_move(coords, piece, prev_piece)
    answer
  end

  def checkmate?(color)
    # only called if color is already in check
    @grid.each_with_index do |row, r|
      row.each_with_index do |col, c|
        piece = @grid[r][c]
        if piece.color == color &&
          piece.moves.length != check_moves(piece).length
            return false
        end
      end
    end
    true
  end

  def opposing_color(color)
    return :blue if color == :yellow
    :yellow
  end

  def in_bounds?(pos)
    pos.all? { |n| n >= 0 && n <= 7 }
  end

  private

  def setup_board
    @grid[0][0] = Rook.new(:blue, self, [0, 0])
    @grid[0][1] = Knight.new(:blue, self, [1, 0])
    @grid[0][2] = Bishop.new(:blue, self, [2, 0])
    @grid[0][3] = Queen.new(:blue, self, [3, 0])
    @grid[0][4] = King.new(:blue, self, [4, 0])
    @grid[0][5] = Bishop.new(:blue, self, [5, 0])
    @grid[0][6] = Knight.new(:blue, self, [6, 0])
    @grid[0][7] = Rook.new(:blue, self, [7, 0])

    @grid[7][0] = Rook.new(:yellow, self, [0, 7])
    @grid[7][1] = Knight.new(:yellow, self, [1, 7])
    @grid[7][2] = Bishop.new(:yellow, self, [2, 7])
    @grid[7][3] = Queen.new(:yellow, self, [3, 7])
    @grid[7][4] = King.new(:yellow, self, [4, 7])
    @grid[7][5] = Bishop.new(:yellow, self, [5, 7])
    @grid[7][6] = Knight.new(:yellow, self, [6, 7])
    @grid[7][7] = Rook.new(:yellow, self, [7, 7])

    row = 1
    col = 0
    while col < 8
      @grid[row][col] = Pawn.new(:blue, self, [col, row])
      col += 1
    end

    row = 6
    col = 0
    while col < 8
      @grid[row][col] = Pawn.new(:yellow, self, [col, row])
      col += 1
    end

    row = 2
    while row < 6
      col = 0
      while col < 8
        @grid[row][col] = NullPiece.instance
        col += 1
      end
      row += 1
    end
  end

  def test_move(coords, piece)
    @grid[coords[3]][coords[2]] = piece
    piece.pos = [coords[2], coords[3]]
    @grid[coords[1]][coords[0]] = NullPiece.instance
  end

  def reset_move(coords, piece, prev_piece)
    @grid[coords[1]][coords[0]] = piece
    piece.pos = [coords[0], coords[1]]
    @grid[coords[3]][coords[2]] = prev_piece
  end

  def king_positions
    # returns {yellow: [x,y], blue: [x,y]}
    result = {}
    @grid.each_with_index do |row, r|
      row.each_with_index do |col, c|
        if @grid[r][c].kind_of?(King) == true
          result[@grid[r][c].color] = [c,r]
        end
      end
    end
    result
  end

  def possible_move?(piece, coords)
    if piece.moves.include?([coords[2],coords[3]]) &&
      ! check_moves(piece).include?([coords[2],coords[3]])
        return true
    end
    false
  end

end
