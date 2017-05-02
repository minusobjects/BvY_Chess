require 'byebug'
class Pawn < Piece

  def initialize(color, board, pos)
    super(color, board, pos, :p, :pawn)
    @start_row = self.pos[1]
  end

  def moves

    potential_moves = []
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

  # This OBVIOUSLY needs refactoring!!! REFACTOR!!!
  def side_attacks
    possible_attacks = []
    start_x = self.pos[0]
    start_y = self.pos[1]
    if @start_row == 1
      if (start_x + 1) < 8 &&
        self.board[start_x + 1, start_y + 1].color != self.color &&
      ! self.board[start_x + 1, start_y + 1].is_a?(NullPiece)
        possible_attacks << [start_x + 1, start_y + 1]
      end
      if (start_x - 1) > -1 &&
        self.board[start_x - 1, start_y + 1].color != self.color &&
      ! self.board[start_x - 1, start_y + 1].is_a?(NullPiece)
        possible_attacks << [start_x - 1, start_y + 1]
      end
    end
    if @start_row == 6
      if (start_x - 1) > -1 &&
        self.board[start_x - 1, start_y - 1].color != self.color &&
      ! self.board[start_x - 1, start_y - 1].is_a?(NullPiece)
        possible_attacks << [start_x - 1, start_y - 1]
      end
      if (start_x + 1) < 8 &&
        self.board[start_x + 1, start_y - 1].color != self.color &&
      ! self.board[start_x + 1, start_y - 1].is_a?(NullPiece)
        possible_attacks << [start_x + 1, start_y - 1]
      end
    end
    possible_attacks
  end

end
