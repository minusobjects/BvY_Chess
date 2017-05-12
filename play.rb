require 'colorize'

require_relative 'game.rb'

game = nil

loop do
  system('clear')
  puts "RubyChess!!!".colorize(:yellow)
  puts "Play vs. computer or human?".colorize(:red)
  puts "Enter 1 for computer, 2 for human.".colorize(:blue)
  str = gets.chomp
  if str.to_i == 1
    game = Game.new('computer')
    break
  elsif str.to_i == 2
    game = Game.new('human')
    break
  end
end

game.start_game
