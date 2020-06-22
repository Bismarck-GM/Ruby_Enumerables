#./enumerals.rb
require_relative "../enumerals.rb"

describe Enumerable do
  let(:arr) { Array(1..5) }
  let(:hash) { Hash.new }
  let(:arr_words) { %w(cat dog wombat) }
  describe "#my_each" do
    it 'If no block is given, an Enumerator is returned.' do
      expect(arr.my_each).not_to eql(arr)
    end
    it 'Calls the given block once for each element in self, passing that element as a parameter. Returns the array itself.' do
      expect(arr.my_each { |x| x }).to eql(arr.each { |x| x })
    end
  end
  describe "#my_each_with_index" do
    it 'If no block is given, an enumerator is returned instead.' do
      expect(arr.my_each_with_index).not_to eql(arr)
    end
    it 'If no block is given, an enumerator is returned instead.' do
      expect(arr.my_each_with_index).to be_a(Enumerator)
    end
    it 'Must return same value as each_with_index if block given.' do
      expect(arr.my_each_with_index { |i, v| i + v }).to eql(arr.each_with_index { |i, v| i + v })
    end
  end
  
end