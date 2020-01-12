require './lib/caesar_cipher.rb'

describe '#caesar_cipher' do
    it "returns an empty string when given an empty string" do
        expect(caesar_cipher("", 3)).to eql("")
    end
    it "returns the original string when given number is 0" do
        expect(caesar_cipher("hello, world", 0)).to eql("hello, world")
    end
    it "only changes the alphabetical characters and not punctuation" do
        expect(caesar_cipher("hehe, i love it!!", 2)).to eql("jgjg, k nqxg kv!!")
    end
    it "works with capital letters as well" do
        expect(caesar_cipher("Can't wait to sleep, YAY", 4)).to eql("Ger'x aemx xs wpiit, CEC")
    end
    it "works with negative numbers as well" do
        expect(caesar_cipher("I am negative, wohoo", -5)).to eql("D vh izbvodqz, rjcjj")
    end
    it "works with numbers larger than 26" do
        expect(caesar_cipher("I am a very large number", 45)).to eql("B tf t oxkr etkzx gnfuxk")
    end
end