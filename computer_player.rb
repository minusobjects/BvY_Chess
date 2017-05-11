class ComputerPlayer

  attr_reader :color

  def initialize(cursor, color, board)
    # cursor is just duck typing
    @color = color
    @board = board
    @possible_pieces = nil;
    @chosen_piece = nil;
  end

  def choose_piece
    @possible_pieces = playable_pieces(@color)
    @chosen_piece = choose_random_piece(@possible_pieces)
  end

  def play_move
    choose_random_move(@possible_pieces,@chosen_piece)
  end

  # could probably use this sort of thing elsewhere, too
  # could be more efficient overall, then
  def piece_valid_moves(piece)
    valid_moves = []
    check_moves = @board.check_moves(piece)
    piece.moves.each do |move|
      valid_moves << move unless check_moves.include?(move)
    end
    valid_moves
  end

  def playable_pieces(color)
    piece_positions = {}
    @board.grid.each_with_index do |row, r|
      row.each_with_index do |col, c|
        if @board[c,r].color == color &&
          piece_valid_moves(@board[c,r]).length > 0
          piece_positions[[c,r]] = piece_valid_moves(@board[c,r])
        end
      end
    end
    piece_positions
  end

  def choose_random_piece(pieces)
    random_piece = pieces.keys.sample
  end

  def choose_random_move(pieces,piece)
    random_move = pieces[piece].sample
  end

end
