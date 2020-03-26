require '../enumberables'

RSpec.describe Enumerable do
  describe '#my_each' do
    it 'Calls the given block once for each element in self ' \
       'passing that element as a parameter. Returns the array itself.' do
      a = %w[a b c]
      expect(a.my_each { |x| print x, ' -- ' }).to eql(a.each { |x| print x, ' -- ' })
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

  describe ''
  # MY_SELECT

  # MY_ALL

  #   MY_ANY

  #   MY_NONE

  #   MY_COUNT

  #   MY_MAP

  #   MY_INJECT

  #   MULTIPLY_ELS
end
