module Steppable

  def moves
    all_moves = []
    directions = self.move_dirs
    directions.each do |dir|
      all_moves << [self.pos[0] + dir[0], self.pos[1] + dir[1]]
    end
    get_valid_moves(all_moves)
  end

  def move_dirs
    case self.type
    when :king
      king_dirs
    when :knight
      knight_dirs
    end
  end

  def knight_dirs
    [[-1, -2], [-2, -1], [-1, 2], [-2, 1], [2, 1], [1, 2], [2, -1], [1, -2]]
  end

  def king_dirs
    [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, -1], [1, 1], [1, -1], [-1, 1]]
  end

  def get_valid_moves(moves)
    potential_moves = []
      moves.each do |move|
        if pos_in_bounds?(move[0], move[1])
          potential_moves << move unless self.board[move[0], move[1]].color == self.color
        end
      end
    potential_moves
  end

  def pos_in_bounds?(x, y)
    x >= 0 && y >= 0 && x <= 7 && y <= 7
  end

end
