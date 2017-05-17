require_relative 'board.rb'
require_relative 'cursor.rb'
require_relative 'human_player.rb'
require_relative 'computer_player.rb'
require_relative 'display.rb'

class Game

  attr_reader :board

  def initialize(player2_type)
    @board = Board.new
    @cursor = Cursor.new([0,0], board)
    @player1 = HumanPlayer.new(@cursor, :yellow, :blue, @board)
    # @player1 = ComputerPlayer.new(@cursor, :yellow, :blue, @board)
    if player2_type == 'computer'
      @player2 = ComputerPlayer.new(@cursor, :blue, :yellow, @board)
    else
      @player2 = HumanPlayer.new(@cursor, :blue, :yellow, @board)
    end
    @display = Display.new(@board, @cursor)
    @current_player = @player1
  end

  def switch_players
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

  def check_message(board, color)
    if board.in_check?(color)
      return "#{color.to_s.capitalize} is in check!"
    else
      return "#{color.to_s.capitalize} is not in check."
    end
  end

  def play(display, board)
    loop do
      begin
        message = "#{@current_player.color.capitalize}, select a piece to move"
        check1 = check_message(@board, :yellow)
        check2 = check_message(@board, :blue)
        display.render(message, check1, check2)
        first_pos = @current_player.choose_piece
        unless first_pos.nil? ||
          @board[first_pos[0],first_pos[1]].color != @current_player.color ||
          @board[first_pos[0],first_pos[1]].type == "null"
            handle_move(display, @current_player, board, first_pos)
            if board.in_check?(@current_player.color)
              break if board.checkmate?(@current_player.color)
            end
        end
      rescue
        retry
      end
    end
    color = @current_player.color
    check1 = "#{color.capitalize} is in checkmate!"
    check2 = "#{board.opposing_color(color).capitalize} wins!\n"
    display.render("", check1, check2)
  end

  def handle_move(display, player, board, first_pos)
    first_pos = first_pos.dup
    second_pos = nil
      until second_pos
        display.render("Where should this piece move to, #{@current_player.color.capitalize}?")
        second_pos = player.play_move
      end
      board.move_piece(first_pos, second_pos)
    switch_players
  end

  def start_game
    play(@display, @board)
  end

end
