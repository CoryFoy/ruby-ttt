require 'serialport'
class ArduinoBoardPresenter < Presenter

  def before_moves_check
    @board_presenter.before_moves_check
  end

  def move_checked
    lambda do |move|
      move_position = move-1
      @board_presenter.move_checked.call(move)
      take_position(move_position)
      sleep(0.1)
      give_up_position(move_position)
    end
  end

  def moves_check_completed
    @board_presenter.moves_check_completed
  end

  def initialize(game_board)
    @board_presenter = BoardPresenter.new(game_board)
    port = "/dev/tty.usbmodemfa131"
    @comm = SerialPort.new(port)
    @game_board = game_board
    @board = game_board.board
  end

  def print_board
    @board.each_with_index do |pos, i|
      if pos.to_s.to_i == 0
        take_position(i)
      end
    end
    @board_presenter.print_board
  end

  def reset_board
    (0..8).each do |i|
      give_up_position(i)
    end
  end

  def give_up_position(pos)
    @comm.putc(0)
    @comm.putc(pos)
  end

  def take_position(pos)
    @comm.putc(1)
    @comm.putc(pos)
  end

  def print_winner
    @board_presenter.print_winner
    reset_board
    if @game_board.wins_for(:x)
      [0,2,4,6,8].each { |i| take_position(i) }
    elsif @game_board.wins_for(:o)
      [0,1,2,3,5,6,7,8].each { |i| take_position(i) }
    else
      [1,4,7,3,5].each { |i| take_position(i) }
    end
    sleep(5)
  end
end
