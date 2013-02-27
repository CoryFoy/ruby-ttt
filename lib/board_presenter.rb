class BoardPresenter

  def initialize(game_board)
    @game_board = game_board
    @board = game_board.board
  end

  def print_board
    line_length = Math.sqrt(@board.length).to_i
    output = ""
    line_length.times do |i|
      output += @board.slice(i*line_length, line_length).join(' | ') + "\n"
    end
    output
  end

  def print_winner
    result = "Draw Game"
    if @game_board.wins_for(:x)
      result = "X Wins!"
    elsif @game_board.wins_for(:o)
      result = "O Wins!"
    end
    result + "\n" + print_board
  end
end
