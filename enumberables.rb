module Enumerable
  def my_each
    return self.to_enum unless block_given?

    length.times do |i|
      yield(self[i])
    end
    self
  end

  def my_each_with_index
    if block_given?
      length.times do |i|
        yield self[i]
        yield i
      end
      self
    else
      elements = []
      length.times do |i|
        elements.push([self[i], i])
      end
      elements
    end
  end

  def my_select
    selected = []
    length.times do |i|
      condition = yield self[i]
      selected.push(self[i]) if condition
    end
    selected
  end

  def my_all?
    return true unless block_given?

    length.times do |i|
      condition = yield self[i]
      next if condition

      return false
    end
    true
  end

  def my_any?
    length.times do |i|
      condition = yield self[i]
      next unless condition

      return true
    end
    false
  end

  def my_none?
    length.times do |i|
      condition = yield self[i]
      next unless condition

      return true
    end
    false
  end

  def my_count
    count = 0
    length.times do |i|
      condition = yield self[i]
      next unless condition

      count += 1
    end
    count
  end

  def my_map(proc = nil)
    unless proc.nil?
      length.times do |i|
        self[i] = proc.call(self[i])
      end
    end

    if block_given?
      length.times do |i|
        self[i] = yield(self[i])
      end
    end
    self
  end

  def my_inject(start = nil)
    accumulated = if start.nil?
                    self[0]
                  else
                    yield(self[0], start)
                  end

    length.times do |i|
      next if i.zero?

      accumulated = yield(self[i], accumulated)
    end
    accumulated
  end

  def multiply_els
    my_inject { |result, element| result * element }
  end
end

array = [1, 1, 1, 1, 2]


puts 'block given'
print(array.each_with_index {|i|})
puts ''
print(array.my_each_with_index {|i|})

puts ''

puts 'block not given'
print(array.each_with_index.to_a)
puts ''
print(array.my_each_with_index.to_a)
