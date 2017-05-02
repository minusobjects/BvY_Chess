require_relative 'board.rb'
require_relative 'cursor.rb'
# BUT display shouldn't actually need cursor - should get from player (player -> game -> board)
require 'colorize'

class Display

  attr_reader :cursor

  # def initialize(board)
  def initialize(board, cursor)
    @board = board
    # @cursor = Cursor.new([0,0], board)
    @cursor = cursor
  end

  def render
    @board.grid.each_index do |row|
      @board.grid[row].each_index do |col|
        if @cursor.cursor_pos == [col, row]
          print "#{@board.grid[row][col].to_s} ".colorize(:red)
        else
          print "#{@board.grid[row][col].to_s} "
        end
      end
      print "\n"
    end
    print "\n"
    print "Current space: #{@cursor.cursor_pos}"
    print "\n"
    print "Available moves: #{@board[@cursor.cursor_pos[0],@cursor.cursor_pos[1]].moves}"
    print "\n"
    print "#{@board[@cursor.cursor_pos[0],@cursor.cursor_pos[1]].type}"
  end

end


# b = Board.new
# d = Display.new(b)
# d.render

def cursor_test(display)
  loop do
    system('clear')
    display.render
    display.cursor.get_input
    puts
  end
end

cursor_test(d)

# p b[5, 1].moves
# p b[2, 6].moves
# # #
# p b[1, 7].moves
# p b[3, 0].moves
# p b[1,7].moves
# p b[1,6].moves
# p b[2,1].moves
