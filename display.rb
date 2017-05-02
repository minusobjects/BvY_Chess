require 'colorize'

class Display

  attr_reader :cursor

  def initialize(board, cursor)
    @board = board
    @cursor = cursor
  end

  def render(message = "")
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
    print "#{@board[@cursor.cursor_pos[0],@cursor.cursor_pos[1]].color.capitalize} #{@board[@cursor.cursor_pos[0],@cursor.cursor_pos[1]].type}"
    print "\n"
    print "#{message}"
  end

end


# print "\n"
# print "Current space: #{@cursor.cursor_pos}"
# print "\n"
# print "Available moves: #{@board[@cursor.cursor_pos[0],@cursor.cursor_pos[1]].moves}"
