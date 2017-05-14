class Pawn < Piece

  def initialize(color, board, pos)
    super(color, board, pos, "\u2659", :pawn)
    @start_row = self.pos[1]
  end

  def moves
    potential_moves = []
    return potential_moves if self.pos[1] == 0 || self.pos[1] == 7
    forward_steps.times do |i|
      potential_moves << [self.pos[0], (self.pos[1] + ((i + 1) * forward_dir))]
      if self.board[potential_moves.last[0], potential_moves.last[1]].is_a?(Piece)
        potential_moves.pop
        break
      end
    end
    potential_moves + side_attacks
  end

  def at_start_row?
    return true if self.pos[1] == @start_row
    false
  end

  def forward_dir
    @start_row == 1 ? 1 : -1
  end

  def forward_steps
    at_start_row? ? 2 : 1
  end

  def find_attacks(start_row, d1, d2)
    start_x = self.pos[0]
    start_y = self.pos[1]

    if(start_x + d1) > 7 || (start_x + d1) < 0
      return []
    end

    attacks = []

    other_piece = self.board[start_x + d1, start_y + d2]

    if @start_row == start_row &&
      other_piece.color != self.color &&
      ! other_piece.is_a?(NullPiece)
        attacks << [start_x + d1, start_y + d2]
    end
    attacks
  end

  def side_attacks
    possible_attacks = []
    possible_attacks += find_attacks(1, 1, 1)
    possible_attacks += find_attacks(1, -1, 1)
    possible_attacks += find_attacks(6, -1, -1)
    possible_attacks += find_attacks(6, 1, -1)
    possible_attacks
  end

end
