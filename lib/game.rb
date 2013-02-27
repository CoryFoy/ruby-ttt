$: << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'board'
require 'board_presenter'
require 'negamax'

board = Board.new
presenter = BoardPresenter.new(board)
negamax = Negamax.new(board)
negamax.move_checked << lambda { |move| print "#{move} " }

while(board.is_playing?)
  puts presenter.print_board
  puts "Move: "
  move = gets.chomp
  board.move(:x, move)
  print "Checking moves: "
  next_move = negamax.next_move_for(:o)
  puts ""
  break unless next_move
  board.move(:o, next_move.first)
end

puts "Game Over"
puts presenter.print_winner
