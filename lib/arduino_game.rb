$: << File.expand_path(File.dirname(__FILE__) + '/../lib')
require 'game'
require 'presenter'
require 'board_presenter'
require 'arduino_board_presenter'
Game.play(ArduinoBoardPresenter)
