require 'spec_helper'
describe BoardPresenter do

  let(:board) { Board.new }

  describe "breaks on the square root of the board" do

    it "breaks into 3 lines for a 9 position board" do
      board.stub(:board) { (1..9).to_a }
      presenter = BoardPresenter.new(board)
      presenter.print_board.count("\n").should == 3
    end

  end

  describe "prints out positions" do
    it "prints the position numbers if no move" do
      board.stub(:board) { (1..9).to_a }
      presenter = BoardPresenter.new(board)
      presenter.print_board.include?("1 | 2 | 3").should == true
    end

    it "prints the move instead of the position number if move" do
      board.move(:x, 1)
      presenter = BoardPresenter.new(board)
      presenter.print_board.include?("x | 2 | 3").should == true
    end
  end

  describe "printing winners" do
    it "prints X as the winner when X wins" do
      board.stub(:wins_for).with(:x) { true }
      board.stub(:wins_for).with(:o) { false }
      presenter = BoardPresenter.new(board)
      presenter.stub(:print_board) { "" }
      presenter.should_receive(:puts).with("X Wins!\n")
      presenter.print_winner
    end
    it "prints Y as the winner when O wins" do
      board.stub(:wins_for).with(:x) { false }
      board.stub(:wins_for).with(:o) { true }
      presenter = BoardPresenter.new(board)
      presenter.stub(:print_board) { "" }
      presenter.should_receive(:puts).with("O Wins!\n")
      presenter.print_winner
    end
    it "prints X as the winner when X wins" do
      board.stub(:wins_for).with(:x) { false }
      board.stub(:wins_for).with(:o) { false }
      presenter = BoardPresenter.new(board)
      presenter.stub(:print_board) { "" }
      presenter.should_receive(:puts).with("Draw Game\n")
      presenter.print_winner
    end
  end

end
