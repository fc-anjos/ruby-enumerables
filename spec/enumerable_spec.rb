require_relative '../enumerables'

# All tests are based on official documentation, found at https://ruby-doc.org/core-2.4.1/Array.html

RSpec.describe Enumerable do
  describe '#my_each' do
    it 'Calls the given block once for each element in self ' \
       'passing that element as a parameter. Returns the array itself.' do
      a = %w[a b c]
      expect(a.my_each { |x| }).to eql(a.each { |x| })
    end

    it 'If no block is given, an Enumerator is returned.' do
      expect([1, 2, 3].my_each.to_a).to eql([1, 2, 3].each.to_a)
    end
  end

  describe '#my_each_with_index' do
    it 'Calls block with two arguments, the item and its index, for each item in enum.  ' \
       'Given arguments are passed through to each().' do
      a = %w[cat dog wombat]

      hash1 = {}
      a.each_with_index do |item, index|
        hash1[item] = index
      end

      hash2 = {}
      a.my_each_with_index do |item, index|
        hash2[item] = index
      end

      expect(hash1).to eql(hash2)
    end

    it 'If no block is given, an Enumerator is returned instead.' do
      expect([1, 2, 3].my_each_with_index.to_a).to eql([1, 2, 3].each_with_index.to_a)
    end
  end

  describe '#my_select' do
    a = [1, 2, 3, 4, 5]
    it 'Returns an array containing all elements of enum for which the given block returns a true value.' do
      expect(a.select(&:even?)).to eql(a.my_select(&:even?))
    end
    it 'If no block is given, an Enumerator is returned instead.' do
      expect(a.select.to_a).to eql(a.my_select.to_a)
    end
  end

  describe '#my_all?' do
    it 'Passes each element of the collection to the given block. ' \
       'The method returns true if the block never returns false or nil.' do
      a = %w[ant cat bear]
      expect(a.all? { |word| word.length >= 3 }).to eql(a.my_all? { |word| word.length >= 3 })
    end

    it 'If the block is not given, Ruby adds an implicit block of { |obj| obj }' \
       'which will cause all? to return true when none of the collection members are false or nil.' do
      a = [nil, true, 99]
      expect(a.all?).to eql(a.my_all?)
    end

    it 'and return false when none of the collection members are false or nil.' do
      a = [true, 1]
      expect(a.all?).to eql(a.my_all?)
    end

    it 'If instead a pattern is supplied, ' \
       'the method returns whether pattern === element for every collection member.' do
      a = %w[ant cat bear]
      expect(a.all?(/t/)).to eql(a.my_all?(/t/))
    end

    it 'Should also work with classes as arguments' do
      a = [1, 2, 3]
      expect(a.all?(Integer)).to eql(a.my_all?(Integer))
    end

    it 'Returning false for when the condition is not met' do
      a = [1, 2, 3]
      expect(a.all?(String)).to eql(a.my_all?(String))
    end

    it 'Working for patterns that are not regexes' do
      a = [3, 3, 3]
      expect(a.all?(3)).to eql(a.my_all?(3))
    end

    it 'Also returning false when the condition is not met' do
      a = [1, 2, 3]
      expect(a.all?(1)).to eql(a.my_all?(1))
    end
  end

  describe '#my_any' do
    it 'Passes each element of the collection to the given block. ' \
       'The method returns true if the block ever returns a value other than false or nil. ' do
      a = %w[ant bear cat]
      expect(a.any? { |word| word.length >= 3 }).to eql(a.my_any? { |word| word.length >= 3 })
    end

    it 'If the block is not given, Ruby adds an implicit block of { |obj| obj }' \
       'which will cause any? to return true if at least one of the collection members is not false or nil.' do
      a = [nil, true, 99]
      expect(a.any?).to eql(a.my_any?)
    end

    it 'and return false if all of the members are false or nil' do
      a = [nil, false]
      expect(a.any?).to eql(a.my_any?)
    end

    it 'If instead a pattern is supplied, ' \
       'the method returns whether pattern === element for any collection member.' do
      a = %w[ant cat bear]
      expect(a.any?(/d/)).to eql(a.my_any?(/d/))
    end

    it 'Should also work with classes as arguments' do
      a = [1, 2, 3]
      expect(a.any?(Integer)).to eql(a.my_any?(Integer))
    end

    it 'Returning false for when the condition is not met' do
      a = [1, 2, 3]
      expect(a.any?(String)).to eql(a.my_any?(String))
    end

    it 'Working for patterns that are not regexes' do
      a = [1, 2, 3]
      expect(a.any?(3)).to eql(a.my_any?(3))
    end

    it 'Also returning false when the condition is not met' do
      a = [1, 2, 3]
      expect(a.any?(4)).to eql(a.my_any?(4))
    end
  end

  describe '#my_none' do
    it 'Passes each element of the collection to the given block. ' \
       'The method returns true if the block never returns true for all elements.' do
      a = %w[ant bear cat]
      expect(a.none? { |word| word.length == 5 }).to eql(a.my_none? { |word| word.length == 5 })
    end

    it 'If the block is not given, none? will return true only if none of the collection members is true.' do
      a = [nil]
      expect(a.none?).to eql(a.my_none?)
    end

    it 'and return false if at least one of the collection members is true' do
      a = [1, nil]
      expect(a.none?).to eql(a.my_none?)
    end

    it 'If instead a pattern is supplied, ' \
       'the method returns whether pattern === element for none of the collection members.' do
      a = %w[ant cat bear]
      expect(a.none?(/d/)).to eql(a.my_none?(/d/))
    end

    it 'Should also work with classes as arguments' do
      a = [1, 2, 3]
      expect(a.none?(String)).to eql(a.my_none?(String))
    end

    it 'Returning false for when the condition is not met' do
      a = [1, 2, 3]
      expect(a.none?(String)).to eql(a.my_none?(String))
    end

    it 'Working for patterns that are not regexes' do
      a = [1, 2, 3]
      expect(a.none?(4)).to eql(a.my_none?(4))
    end

    it 'Also returning false when the condition is not met' do
      a = [1, 2, 3]
      expect(a.none?(1)).to eql(a.my_none?(1))
    end
  end

  describe '#my_count' do
    ary = [1, 2, 3, 4]

    it 'Returns the number of items in enum through enumeration. ' \
      'If an argument is given, the number of items in enum that are equal to item are counted.' do
      expect(ary.count(2)).to eql(ary.my_count(2))
    end

    it ' If a block is given, it counts the number of elements yielding a true value.' do
      expect(ary.count(&:even?)).to eql(ary.my_count(&:even?))
    end
  end

  describe '#my_count' do
    ary = [1, 2, 3, 4]

    it 'Returns the number of items in enum through enumeration. ' \
      'If an argument is given, the number of items in enum that are equal to item are counted.' do
      expect(ary.count(2)).to eql(ary.my_count(2))
    end

    it ' If a block is given, it counts the number of elements yielding a true value.' do
      expect(ary.count(&:even?)).to eql(ary.my_count(&:even?))
    end
  end

  describe '#my_select' do
    a = [1, 2, 3, 4, 5]
    it 'Returns an array containing all elements of enum for which the given block returns a true value.' do
      expect(a.select(&:even?)).to eql(a.my_select(&:even?))
    end

    it 'If no block is given, an Enumerator is returned instead.' do
      expect(a.select.to_a).to eql(a.my_select.to_a)
    end
  end

  describe '#my_map' do
    it 'Returns a new array with the results of running block once for every element in enum.' do
      expect((1..4).map { |i| i * i }).to eql((1..4).my_map { |i| i * i })
    end
  end

  describe '#my_inject' do
    it 'Combines all elements of enum by applying a binary operation, ' \
       'specified by a block or a symbol that names a method or operator.' \
       'If you specify a block,' \
       'then for each element in enum the block is passed an accumulator value (memo) and the element.' do
      expect((5..10).inject { |sum, n| sum + n }).to eql((5..10).my_inject { |sum, n| sum + n })
    end

    it 'If you specify a symbol instead, ' \
       'then each element in the collection will be passed to the named method of memo. ' do
      expect((5..10).reduce(1, :+)).to eql((5..10).my_inject(1, :+))
    end

    it 'If you do not explicitly specify an initial value for memo, ' \
       'then the first element of collection is used as the initial value of memo.' do
      expect((5..10).reduce(:+)).to eql((5..10).my_inject(:+))
    end
  end

  describe '#multiply_els' do
    it 'Multiplies all the elements of the array together by using #my_inject' do
      a = [2, 4, 5]
      expect(a.multiply_els).to eql(a.inject(:*))
    end
  end
end
