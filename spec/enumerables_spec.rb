# ./enumerals.rb
require_relative '../enumerals.rb'

describe Enumerable do
  let(:arr) { Array(1..5) }
  let(:hash) { {} }
  let(:arr_words) { %w[cat dog wombat] }
  let(:arr_with_ts) { %w[ant bat cat] }
  let(:arr_nums_strings) { [1, 2, 'a_string', 'another_string'] }
  let(:arr_falsey) { [false, nil, 1 > 2] }
  let(:arr_empty) { [] }
  let(:my_range) { 1..5 }
  let(:my_map_arg) { proc { |x| x**2 } }

  describe '#my_each' do
    it 'If no block is given, an Enumerator is returned.' do
      expect(arr.my_each).not_to eql(arr)
    end
    it 'Calls the given block once for each element in self, passing that element as a parameter. Returns array.' do
      expect(arr.my_each { |val| puts val }).to eql(arr.each { |val| puts val })
    end
    it 'Must throw argument error if given arguments ().' do
      expect { arr.my_each(9) }.to raise_error(ArgumentError)
    end
  end
  describe '#my_each_with_index' do
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
  describe '#my_select' do
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
  describe '#my_all' do
    it 'Must return true if given regular expression returns true.' do
      expect(arr_with_ts.my_all?(/t/)).to eql(true)
    end
    it 'Must return true if given class returns true.' do
      expect(arr.my_all?(Integer)).to eql(true)
    end
    it 'Must return true if no block is given.' do
      expect(arr_words.my_all?).not_to eql(false)
    end
    it 'Must give same result as #all? when block given. ' do
      expect(arr.my_all? { |value| value >= 2 }).to eql(arr.all? { |value| value >= 2 })
    end
    it 'Must use an argument instead of block when given an argument and a block.' do
      expect(arr.my_all?(/t/) { |v| v >= 0 }).not_to eql(true)
    end
  end
  describe '#my_any' do
    it 'Must return true if at least one element matches the regular expression.' do
      expect(arr_words.my_any?(/t/)).to eql(true)
    end
    it 'Must return true if at least one element matches the given class.' do
      expect(arr_nums_strings.my_any?(Integer)).to eql(true)
    end
    it 'Must return false if array is falsey.' do
      expect(arr_falsey.my_any?).not_to eql(true)
    end
    it 'Must give same result as #any? when block given.' do
      expect(arr.my_any? { |value| value >= 2 }).to eql(arr.any? { |value| value >= 2 })
    end
    it 'Must use an argument instead of block when given an argument and a block.' do
      expect(arr.my_any?(/t/) { |v| v >= 0 }).not_to eql(true)
    end
    it 'Must return false if array is empty.' do
      expect(arr_empty.my_any?).not_to eql(true)
    end
  end
  describe '#my_none?' do
    it 'Must return true if the block never returns true for all elements.' do
      expect(arr_words.my_none? { |word| word.length == 5 }).to equal(true)
    end
    it 'Must return false if the block returns true for a element.' do
      expect(arr_words.my_none? { |word| word.length >= 4 }).not_to equal(true)
    end
    it 'Must return false if at least one element matches the regular expression.' do
      expect(arr_words.my_none?(/d/)).not_to eql(true)
    end
    it 'Must return true if array is empty.' do
      expect(arr_empty.my_none?).not_to eql(false)
    end
    it 'Must return true if array is falsey.' do
      expect(arr_falsey.my_none?).not_to eql(false)
    end
    it 'Must use an argument instead of block when given an argument and a block.' do
      expect(arr.my_none?(/t/) { |v| v >= 0 }).not_to eql(false)
    end
    it 'Must give same result as #none? when block given.' do
      expect(arr.my_none? { |value| value >= 2 }).to eql(arr.none? { |value| value >= 2 })
    end
  end
  describe '#my_count' do
    it 'Must return the number of elements when no block or arguments are given' do
      expect(arr.my_count).to eql(5)
    end
    it 'Must return the number of items in enum that are counted if an argument is given' do
      expect(arr.my_count(1)).not_to eql(2)
    end
    it 'Must return the number of items in enum that are counted using the block that is passed' do
      expect(arr.my_count { |x| (x % 2).zero? }).to eql(2)
    end
    it 'Must give same result as #count when block given.' do
      expect(arr.my_count { |x| (x % 2).zero? }).to eql(arr.count { |x| (x % 2).zero? })
    end
    it 'Must use an argument instead of block when given an argument and a block.' do
      expect(arr.my_count(2) { |value| value }).not_to eql(3)
    end
    it 'Must accept a range' do
      expect(my_range.my_count { |x| (x % 2).zero? }).not_to eql(3)
    end
  end
  describe '#my_map' do
    it 'Must return a new array with the results of running block once for every element in enum.' do
      expect(arr.my_map { |value| value * 2 }).to eql([2, 4, 6, 8, 10])
    end
    it 'Must accept a range and return a new array with the results of running block.' do
      expect(my_range.my_map { |value| value * 2 }).to eql([2, 4, 6, 8, 10])
    end
    it 'Must use an argument (block) instead of block when given an argument and a block.' do
      expect(arr.my_map(my_map_arg) { |value| value }).to eql([1, 4, 9, 16, 25])
    end
    it 'If no block is given, an enumerator is returned instead.' do
      expect(arr.my_map).to be_a(Enumerator)
    end
  end
  describe '#my_inject' do
    it 'Must return same value as #inject when passed a block.' do
      expect(arr.my_inject { |value| value * 2 }).to eql(arr.inject { |value| value * 2 })
    end
    it 'Must return same value as #inject when passed a range.' do
      expect(my_range.my_inject { |sum, n| sum + n }).to eql(my_range.inject { |sum, n| sum + n })
    end
    it 'Must accept multiple arguments and symbols.' do
      expect(my_range.my_inject(1, :*)).to eql(120)
    end
    it 'Must raise LocalJumpError when no block is given.' do
      expect { arr.my_inject }.to raise_error(LocalJumpError)
    end
    it 'Must use first element in enum as starting value when given a block.' do
      expect(arr.my_inject(10) { |product, n| product * n }).to eql(12_000)
    end
  end
  describe '#multiply_els' do
    it 'Must multiply the elements using my inject to produce the correct output.' do
      expect(arr.multiply_els).to eql(120)
    end
  end
end
