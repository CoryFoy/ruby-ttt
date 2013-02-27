class Negamax

  def initialize(board)
    @board = board
    @move_checked_listeners = []
    @no_moves_listeners = []
  end

  WORST_MOVE = -5000

  def self.for(board, player)
    if board.wins_for(player)
      return 1
    elsif board.wins_for(opponent_for(player))
      return -1
    else
      best = WORST_MOVE
      board.open_moves.each do |move|
        dup_board = Board.dup(board)
        dup_board.move(player, move)
        s = -Negamax.for(dup_board, opponent_for(player))
        best = s if s > best 
      end
      best = 0 if best == WORST_MOVE
      return best
    end
  end

  def self.opponent_for(player)
    player == :x ? :o : :x
  end

  def move_checked
    @move_checked_listeners
  end

  def move_checked_event(move)
    @move_checked_listeners.each { |listener| listener.call(move) }
  end

  def next_move_for(player)
    moves = {}
    @board.open_moves.each do |move|
      dup_board = Board.dup(@board)
      dup_board.move(player, move)
      move_checked_event(move)
      moves[move] = -Negamax.for(dup_board, Negamax.opponent_for(player))
    end
    puts moves.inspect

    return moves.max { |a,b| a[1] <=> b[1] }
  end

end
