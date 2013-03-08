class Presenter

  def before_moves_check
  end

  def move_checked
  end

  def moves_check_completed
  end

  def bad_move
    lambda { puts "Invalid move"; return true; }
  end

  def get_next_move
    puts "Move: "
    return gets.chomp
  end

  def game_over
    puts "Game Over"
  end

end
