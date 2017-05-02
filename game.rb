require 'byebug'

require_relative 'board.rb'
require_relative 'cursor.rb'
require_relative 'human_player.rb'
require_relative 'display.rb'

class Game

  attr_reader :board

  def initialize
    @board = Board.new
    @cursor = Cursor.new([0,0], board)
    @player1 = HumanPlayer.new(@cursor, :yellow)
    @player2 = HumanPlayer.new(@cursor, :blue)
    @display = Display.new(@board, @cursor)
    @current_player = @player1
  end

  def switch_players
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

  def play(display, board)
    loop do
      begin
        display.render("#{@current_player.color.capitalize}, select a piece to move")
        first_pos = @current_player.play_move
        unless first_pos.nil? ||
          @board[first_pos[0],first_pos[1]].color != @current_player.color ||
          @board[first_pos[0],first_pos[1]].type == "null"
            handle_move(display, @current_player, board, first_pos)
        end
      rescue
        retry
      end
    end
  end

  def handle_move(display, player, board, first_pos)
    first_pos = first_pos.dup
    second_pos = nil
      until second_pos
        display.render("Where should this piece move to, #{@current_player.color.capitalize}?")
        second_pos = player.play_move
      end
      board.move_piece(first_pos, second_pos)
      second_pos = nil
    switch_players
  end

  def start_game
    play(@display, @board)
  end

end

g = Game.new
g.start_game
