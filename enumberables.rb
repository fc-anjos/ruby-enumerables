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
        if condition
          selected.push(self[i])
        end
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

  def my_none?
    length.times do |i|
      condition = yield self[i]
      next if !condition
      return false
    end
    true
  end

  def my_count
    count = 0
    length.times do |i|
      condition = yield self[i]
      next if !condition
      count += 1
    end
    count
  end

  # my_map
  def my_map
    length.times do |i|
      self[i] = yield(self[i])
    end
    self
  end

  # my_inject
  def my_inject(start)
    puts('')
    puts(start)
    length.times do |i|
      print(yield self[i])
    end
  end
end

array = [1, 2, 3, 4]

print(array.inject(3) { |result, element| result - element })
array.my_inject(3) { |result, element| result - element }
