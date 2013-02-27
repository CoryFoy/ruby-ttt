require 'spec_helper'

describe "Negamax" do

  let(:board) { double(Board) }
  let(:dup_board) { double(Board) }

  before do
    Board.stub(:dup) { dup_board }
    board.stub(:wins_for).with(:x) { false }
    board.stub(:wins_for).with(:o) { false }
    board.stub(:open_moves) { [] }
    dup_board.stub(:wins_for).with(:x) { false }
    dup_board.stub(:wins_for).with(:o) { false }
    dup_board.stub(:open_moves) { [] }
    dup_board.stub(:move)
  end

  it "returns 1 for player winning" do
    board.stub(:wins_for).with(:x) { true }
    Negamax.for(board, :x).should == 1
  end

  it "returns -1 for opponent winning" do
    board.stub(:wins_for).with(:o) { true }
    Negamax.for(board, :x).should == -1
  end

 it "returns 0 for no open moves" do
    Negamax.for(board, :x).should == 0
  end

  describe "No win" do

    it "gets the remaining open moves" do
      board.should_receive(:open_moves)
      Negamax.for(board, :x)
    end

    it "plays the next open move" do
      board.stub(:open_moves).and_return([2])
      dup_board.stub(:open_moves).and_return([])
      dup_board.should_receive(:move).with(:x, 2)
      Negamax.for(board, :x)
    end

    it "finds the results for moves based on this one" do
      board.stub(:open_moves) { [2] }
      Negamax.class_eval do
        class << self
          alias_method :for_normal, :for
        end
      end
      Negamax.should_receive(:for) { 0 }
      Negamax.for_normal(board, :x)
    end

    it "returns best if next move results in win for player" do
      board.stub(:open_moves).and_return([2])
      dup_board.stub(:open_moves).and_return([])
      dup_board.stub(:wins_for).with(:x).and_return(true)
      Negamax.for(board, :x).should == 1
    end

    it "returns worst if next move results in win for opponent" do
      board.stub(:open_moves).and_return([2])
      dup_board.stub(:open_moves).and_return([])
      dup_board.stub(:wins_for).with(:o).and_return(true)
      Negamax.for(board, :x).should == -1
    end

  end


end
