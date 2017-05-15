POINTS = {
  null: 0,
  pawn: 1,
  rook: 2,
  knight: 3,
  bishop: 4,
  queen: 5
}

class ComputerPlayer

  attr_reader :color

  def initialize(cursor, color, opp_color, board)
    # cursor is just duck typing
    @color = color
    @opp_color = opp_color
    @board = board
    @possible_pieces = nil;
    @chosen_piece = nil;
  end

  def choose_piece
    all_pieces = playable_pieces(@color)
    @possible_pieces = move_hierarchy(all_pieces)
    @chosen_piece = choose_random_piece(@possible_pieces)
  end

  def play_move
    choose_random_move(@possible_pieces,@chosen_piece)
  end

  private

  def piece_valid_moves(piece)
    valid_moves = []
    check_moves = @board.check_moves(piece)
    piece.moves.each do |move|
      valid_moves << move unless check_moves.include?(move)
    end
    valid_moves
  end

  def playable_pieces(color)
    # returns a hash where piece positions are k and their possible moves are v
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

  def move_hierarchy(pieces)
    ordered_moves = Array.new(4) { Array.new }
    # 0 = checkmate, 1 = check, 2 = capture, 3 = other
    capture_obj = {}

    pieces_start = pieces.keys
    pieces_start.each do |start_pos|
      pieces[start_pos].each do |end_pos|
        coords = [start_pos[0],start_pos[1],end_pos[0],end_pos[1]]
        check = @board.puts_color_in_check?(coords, @opp_color)
        points = capture_points(end_pos[0],end_pos[1])
        if check == :mate
          ordered_moves[0] << start_pos << end_pos
        elsif check == :check
          ordered_moves[1] << start_pos << end_pos
        elsif points > 0
          capture_obj[points] ||= []
          capture_obj[points] << start_pos << end_pos
        else
          ordered_moves[3] << start_pos << end_pos
        end
      end
    end
    ordered_moves[2] = capture_obj[capture_obj.keys.max] unless capture_obj.empty?
    select_moves(ordered_moves)
  end

  def select_moves(ordered_moves)
    moves = {}
    if ! ordered_moves[0].empty?
      selected_moves = ordered_moves[0]
    elsif ! ordered_moves[1].empty?
      selected_moves = ordered_moves[1]
    elsif ! ordered_moves[2].empty?
      selected_moves = ordered_moves[2]
    else
      selected_moves = ordered_moves[3]
    end
    i = 0
    while i < selected_moves.length
      moves[selected_moves[i]] ||= []
      moves[selected_moves[i]] << selected_moves[i + 1]
      i += 2
    end
    # returns a hash: start positions are k, possible moves are v
    # hash only contains the most desirable moves
    moves
  end

  def capture_points(end_x,end_y)
    piece = @board[end_x,end_y]
    POINTS[piece.type.to_sym]
  end

  def choose_random_piece(pieces)
    random_piece = pieces.keys.sample
  end

  def choose_random_move(pieces,piece)
    random_move = pieces[piece].sample
  end

end
