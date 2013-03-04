require 'board'
require 'negamax'

class Game

  def self.play(presenter_class)
    board = Board.new
    presenter = presenter_class.new(board)
    negamax = Negamax.new(board)
    negamax.move_checked << presenter.move_checked

    while(board.is_playing?)
      puts presenter.print_board
      puts "Move: "
      move = gets.chomp
      board.move(:x, move)
      presenter.before_moves_check
      next_move = negamax.next_move_for(:o)
      presenter.moves_check_completed
      break unless next_move
      board.move(:o, next_move.first)
    end

    puts "Game Over"
    puts presenter.print_winner
  end

end
