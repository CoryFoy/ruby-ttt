class Board

  def self.dup(board)
    Marshal.load(Marshal.dump(board))
  end

  def is_valid_move?(move)
    open_moves.include?(move.to_i)
  end

  def board
    @board
  end

  def initialize
    @board = (1..9).to_a
  end

  def open_moves
    @board.select { |m| m.is_a? Numeric }
  end

  def move(player, pos)
    raise ArgumentError unless is_valid_move?(pos.to_i)
    pos = pos.to_i
    @board[pos-1] = player
  end

  def wins_for(player)
    wins = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,4,8],
      [2,4,6],
      [0,3,6],
      [1,4,7],
      [2,5,8]
    ]
    wins.each do |win_state|
      streak = win_state.select { |m| @board[m] == player }
      return true if streak.length == 3
    end
    return false
  end

  def is_playing?
    !(wins_for(:x) || wins_for(:o))
  end

end
