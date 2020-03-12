module Enumerable

  def my_each
    length.times do |i|
      yield self[i]
    end
  end

  def my_each_with_index
    length.times do |i|
      yield self[i]
      yield i
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

  # my_map
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

print([1,2,3,4,5,6].select { |n| n.even? })
print([1,2,3,4,5,6].my_select { |n| n.even? })
