require './lib/game'

describe Game do
    g = Game.new("A", "a", "B", "b")
    g.board = Board.new()
    describe "#valid_move?" do
        it "returns true when given move is valid" do
            expect(g.valid_move?([1, 2])).to eql(true)
        end
        it "returns false when one of the given values is nil" do
            expect(g.valid_move?([nil, 1])).to eql(false)
        end
        it "returns false when the values are too big" do
            expect(g.valid_move?([3, 3])).to eql(false)
        end
        g.board.board = [["a", "-", "-"],["-", "-", "-"],["-", "-", "-"]]
        it "returns false when the given position is already filled" do
            expect(g.valid_move?([0, 0])).to eql(false)
        end
    end
    board1 = [["a", "a", "a"],["-", "b", "-"],["b", "-", "-"]]
    board2 = [["a", "b", "-"],["a", "b", "-"],["a", "-", "-"]]
    board3 = [["a", "b", "-"],["-", "a", "-"],["b", "b", "a"]]
    board4 = [["-", "a", "-"],["-", "b", "-"],["b", "-", "a"]]
    describe "#over?" do
        it "returns true when a row is filled" do
            g.board.board = board1
            expect(g.over?).to eql([true, "a"])
        end
        it "returns true when a column is filled" do
            g.board.board = board2
            expect(g.over?).to eql([true, "a"])
        end
        it "returns true when a diagonal is filled" do
            g.board.board = board3
            expect(g.over?).to eql([true, "a"])
        end
        it "returns false when no one has won" do
            g.board.board = board4
            expect(g.over?).to eql(false)
        end
    end
    describe "#find_winner" do
        it "returns the player with the mark given" do
            expect(g.find_winner("a")).to eql(g.player1)
        end
        it "returns the player with the mark given" do 
            expect(g.find_winner("b")).to eql(g.player2)
        end
    end
end