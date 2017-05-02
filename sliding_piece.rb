module SlidingPiece

  def moves
    all_moves = []
    directions = self.move_dirs
    directions.each do |dir|
      all_moves += grow_unblocked_moves_in_dirs(dir)
    end
    all_moves
  end

  # private

  def move_dirs
    case self.type
    when :rook
      horizontal_dirs
    when :bishop
      diagonal_dirs
    when :queen
      horizontal_dirs + diagonal_dirs
    end
  end

  def horizontal_dirs
    [[-1, 0], [1, 0], [0, -1], [0, 1]]
  end

  def diagonal_dirs
    [[-1, -1], [1, 1], [1, -1], [-1, 1]]
  end

  def grow_unblocked_moves_in_dirs(dir)
    x = dir[0]
    y = dir[1]

    potential_moves = []
    x_step = self.pos[0] + x
    y_step = self.pos[1] + y

    until !pos_in_bounds?(x_step, y_step)
      # continuously updates list of possible next positions
      # if position contains piece, it will be the last on the list
      if self.board.grid[y_step][x_step].is_a?(Piece)
        potential_moves << [x_step, y_step]
        break
      end
      potential_moves << [x_step, y_step]
      x_step += x
      y_step += y
    end

    # remove last position if it contains a piece of same color
    unless potential_moves.empty?
      # check that we're not replacing the same color
      last_x, last_y = potential_moves.last
      potential_moves.pop if self.board[last_x, last_y].color == self.color
    end
    potential_moves
  end

  def pos_in_bounds?(x, y)
    x >= 0 && y >= 0 && x <= 7 && y <= 7
  end

end
