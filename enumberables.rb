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
    return self.to_enum unless block_given?
    selected = []
    length.times do |i|
      condition = yield self[i]
      selected.push(self[i]) if condition
    end
    selected
  end

  def my_all?
    if block_given?
      length.times do |i|
        condition = yield self[i]
        next if condition

        return false
      end
      true

    elsif has_nil?
      false
    else
      true
    end
  end

  def has_nil?
    length.times do |i|
      return true if self[i] == false || self[i].nil?
    end
    false
  end

  def has_true?
    length.times do |i|
      return true if self[i] == true
    end
    false
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


array = [1, 1, nil]

puts 'block given'
print(array.all? {|i| i == 1})
puts ''
print(array.my_all? {|i| i == 1})
puts ''
puts 'block not given'
print(array.all?)
puts ''
print(array.my_all?)
