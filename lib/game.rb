require 'board'
require 'negamax'

class Game

  def self.play(presenter_class)
    board = Board.new
    bad_move = nil
    presenter = presenter_class.new(board)
    negamax = Negamax.new(board)
    negamax.move_checked << presenter.move_checked
    bad_move = presenter.bad_move

    while(board.is_playing?)
      move = presenter.get_next_move
      if(!board.is_valid_move?(move) && bad_move)
        should_ask_again = bad_move.call
        next if should_ask_again
      end
      board.move(:x, move)
      presenter.before_moves_check
      next_move = negamax.next_move_for(:o)
      presenter.moves_check_completed
      break unless next_move
      board.move(:o, next_move.first)
    end

    presenter.game_over
    presenter.print_winner
  end

end
