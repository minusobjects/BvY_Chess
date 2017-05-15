require 'colorize'

class Display

  attr_reader :cursor

  def initialize(board, cursor)
    @board = board
    @cursor = cursor
  end

  def render(message = "", check1 = "", check2 = "")
    system('clear')
    @board.grid.each_index do |row|
      @board.grid[row].each_index do |col|
        if @cursor.cursor_pos == [col, row]
          print "#{@board.grid[row][col].to_s} ".colorize(:red).encode('utf-8')
        else
          print "#{@board.grid[row][col].to_s} ".encode('utf-8')
        end
      end
      print "\n"
    end
    print "\n"
    print "#{message}"
    print "\n\n"
    print "#{check1}"
    print "\n"
    print "#{check2}"
  end

end
