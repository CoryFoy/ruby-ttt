$: << File.expand_path(File.dirname(__FILE__) + '/../lib')
 require 'game'
 require 'presenter'
 require 'board_presenter'
 require 'arduino_board_presenter'
 require 'timeout'

ARDUINO_PORT = '/dev/tty.usbmodemfd121'

def check_for_player
  puts "A CHALLENGER APPEARS! HIT ENTER TO PLAY"
  response = nil
  begin
  Timeout::timeout(5) do
    response = gets
  end
  rescue
    puts "Not so tough, are ya"
    response = nil
  end
  return response != nil
end


while(true)
  puts "Looking for fresh players..."
  should_break = false
  comm = SerialPort.new(ARDUINO_PORT)
  sleep(3)
  comm.putc(97)
  puts "Scanning"
  comm.putc(97)
  while (line = comm.readline)
    puts line.chomp
    if line.chomp == "1"
      should_break = check_for_player
      if should_break
        break
      else
        comm.seek(0, IO::SEEK_END)
      end
    end
  end
  comm.close
  Game.play(ArduinoBoardPresenter)
end

# while(true)
#   puts "Waiting for players"
#   ArduinoBoardPresenter.wait_for_player(callback)
#   Game.play(ArduinoBoardPresenter)
# end
