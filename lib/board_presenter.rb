class BoardPresenter < Presenter

  def before_moves_check
    print "Checking moves: "
  end

  def move_checked
    lambda { |move| print "#{move} " }
  end

  def moves_check_completed
    puts ""
  end

  def get_next_move
    print_board
    puts "Move: "
    return gets.chomp
  end

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
    puts output
    output
  end

  def print_winner
    result = "Draw Game"
    if @game_board.wins_for(:x)
      result = "X Wins!"
    elsif @game_board.wins_for(:o)
      result = "O Wins!"
    end
    puts result + "\n"
    print_board
  end
end
