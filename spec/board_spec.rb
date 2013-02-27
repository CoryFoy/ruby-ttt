require 'spec_helper'
describe Board do

  let(:board) { Board.new }

  describe "Moving" do
    it "marks the board with the player when moving" do
      board.move(:x, 3)
      board.board.include?(:x)
      board.board[2].should == :x
    end

    it "raises an error if an invalid move when moving" do
      board.move(:x, 3)
      expect { board.move(:o, 3) }.to raise_error
    end
  end

  describe "Available moves" do

    it "knows all moves are available at first" do
      board.open_moves.length.should == 9
    end

    it "removes a move from available moves when played" do
      board.move(:x, 5)
      board.open_moves.include?(5).should == false
    end

  end

  describe "Invalid moves" do
    it "identifies out of range values as invalid moves" do
      board.is_valid_move?(14).should == false
    end

    it "identifies in range but taken values as invalid moves" do
      board.move(:x, 5)
      board.is_valid_move?(5).should == false
    end

    it "identifies in range and available values as valid moves" do
      board.is_valid_move?(5).should == true
    end
  end

  describe "Winning" do
    it "wins for horizontal" do
      board.move(:x, 1)
      board.move(:x, 2)
      board.move(:x, 3)
      board.wins_for(:x).should == true
    end

    it "wins for diagonal" do
      board.move(:o, 1)
      board.move(:o, 5)
      board.move(:o, 9)
      board.wins_for(:o).should == true
    end

    it "wins for horizontal" do
      board.move(:o, 1)
      board.move(:o, 4)
      board.move(:o, 7)
      board.wins_for(:o).should == true
    end

    it "doesn't win otherwise" do
      board.move(:o, 1)
      board.move(:x, 2)
      board.move(:o, 3)
      board.wins_for(:o).should == false
      board.wins_for(:x).should == false
    end

    it "stops playing when x wins" do
      board.stub(:wins_for).with(:x) { true }
      board.stub(:wins_for).with(:o) { false }
      board.is_playing?.should == false
    end

    it "stops playing when o wins" do
      board.stub(:wins_for).with(:x) { false }
      board.stub(:wins_for).with(:o) { true }
      board.is_playing?.should == false
    end

  end
end
