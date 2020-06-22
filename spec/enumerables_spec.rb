#./enumerals.rb
require_relative "../enumerals.rb"

describe Enumerable do
  let(:arr) { Array(1..5) }
  let(:hash) { Hash.new }
  let(:arr_words) { %w(cat dog wombat) }
  let(:arr_with_ts) { %w(ant bat cat) }

  describe "#my_each" do
    it 'If no block is given, an Enumerator is returned.' do
      expect(arr.my_each).not_to eql(arr)
    end
    it 'Calls the given block once for each element in self, passing that element as a parameter. Returns the array itself.' do
      expect(arr.my_each { |x| x }).to eql(arr.each { |x| x })
    end
    it 'Must throw argument error if given arguments ().' do
      expect { arr.my_each(9) }.to raise_error(ArgumentError)
    end
  end
  describe "#my_each_with_index" do
    it 'If no block is given, an enumerator is returned instead.' do
      expect(arr.my_each_with_index).not_to eql(arr)
    end
    it 'If no block is given, an enumerator is returned instead.' do
      expect(arr.my_each_with_index).to be_a(Enumerator)
    end
    it 'Must return same value as #each_with_index if block given.' do
      expect(arr.my_each_with_index { |i, v| i + v }).to eql(arr.each_with_index { |i, v| i + v })
    end
    it 'Must throw argument error if given arguments ().' do
      expect { arr.my_each_with_index(9) }.to raise_error(ArgumentError)
    end
  end
  describe "#my_select" do
    it 'If no block is given, an enumerator is returned instead.' do
      expect(arr.my_select).not_to eql(arr)
    end
    it 'If no block is given, an enumerator is returned instead.' do
      expect(arr.my_select).to be_a(Enumerator)
    end
    it 'Must return same value as #select if block given.' do
      expect(arr.my_select { |v| v > 3 }).to eql(arr.select { |v| v > 3 })
    end
    it 'Must throw argument error if given arguments ().' do
      expect { arr.my_select(9) }.to raise_error(ArgumentError)
    end
  end
  describe "#my_all" do 
    it "Must return true if given regular expression returns true." do 
      expect(arr_with_ts.my_all?(/t/)).to eql(true)
    end
    it "Must return true if given class returns true." do 
      expect(arr.my_all?(Integer)).to eql(true)
    end
    it "Must return true if no block is given." do
      expect(arr_words.my_all?).not_to eql(false)
    end 
    it "Must give same result as all? when block given. " do 
      expect(arr.my_all?{|value| value >= 2 }).to eql(arr.all?{|value| value >= 2 })
    end
    it "Must use an argument instead of block when given an argument and a block." do
      expect(arr.my_all?(/t/) { |v| v >= 0 }).not_to eql(true)
    end
  end
  
end