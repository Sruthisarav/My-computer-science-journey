require './lib/enumerables.rb'

describe Enumerable do
    describe "#my_all?" do
        it "returns true if array is empty" do
            expect([].my_all?{|num| num > 0}).to eql(true)
        end
        it "returns false if even one elemnt doesn't meet condition" do
            expect([1, 5, -1].my_all? {|num| num < 0}).to eql(false)
        end
        it "returns true when all elements meet condition" do 
            expect([1, 2, 4, 5].my_all? {|num| num > 0}).to eql(true)
        end
        it "works with string arrays too" do 
            expect(["hello", "as", "now"].my_all? {|str| str.length > 0}).to eql(true)
        end
    end
    describe '#my_any?' do
        it "returns true if array is empty" do
            expect([].my_any?{|num| num > 0}).to eql(true)
        end
        it "returns true if at least one element meets condition" do
            expect([1, 4, 5].my_any? {|num| num >= 5}).to eql(true)
        end
        it "returns false is all elements do not meet condition" do
            expect(['a', 'b', 'c'].my_any? {|char| char == 'd'}).to eql(false)
        end
        it "returns true if all elements meet condition" do
            expect([1, 2, 4, 5].my_any? {|num| num > 0}).to eql(true)
        end
    end
    describe '#my_none?' do
        it "returns true if array is empty" do
            expect([].my_none? {|num| num > 0}).to eql(true)
        end
        it "returns true if all elements do not meet condition" do
            expect([1, 3, 5].my_none? {|num| num < 0}).to eql(true)
        end
        it "returns false if even one element meets condition" do
            expect([1, 5, 6].my_none? {|num| num > 5}). to eql(false)
        end
        it "returns false if all elements meet condition" do
            expect([1, 2, 4, 5].my_none? {|num| num > 0}).to eql(false)
        end
    end
    describe "#my_count" do
        it "returns 0 if array is empty" do
            expect([].my_count {|num| num > 0}).to eql(0)
        end
        it "returns 0 if all elements fail to meet condition" do
            expect([1, 3, 5].count {|num| num < 0}).to eql(0)
        end
        it "returns 1 if one elements meets conidtion" do
            ['a', 'b', 'c'].count {|char| char == 'b'}
        end
        it "returns count if more than one element meets condition" do
            expect([1, 5, 7, 9].my_count {|num| num >= 6}).to eql(2)
        end
    end
    describe "#my_map" do
        it "returns an empty array when given an empty array" do
            expect([].my_map).to eql([])
        end
        it "my_map works when given a proc" do
            expect([1, 2, 3, 4].my_map(Proc.new {|num| num*2})).to eql([2, 4, 6, 8])
        end
        it "my_map works when a block is given instead of a proc" do
            expect([1, 3, 5].my_map {|ele| ele*2}).to eql([2, 6, 10])
        end
    end
    describe "#my_inject" do
        it "returns nil when array is empty" do
            expect([].my_inject).to eql(nil)
        end
        it "returns the result of the blk given when there's no accumulator" do
            expect([1, 2, 3, 4].my_inject {|sum, num| sum*num}).to eql(24)
        end
        it "returns the result when there's an accumulator given" do
            expect([1, 2, 3].my_inject(0){|result, num| result-num}).to eql(-6)
        end
    end

end