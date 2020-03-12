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

  def my_any?
    puts 'ok'
  end

  def my_none
    puts 'ok'
  end

  def my_count
    puts 'ok'
  end

  # my_map
  def mymap
    puts 'ok'
  end

  # my_inject
  def my_inject
    puts 'ok'
  end


end

array = ['a', 'a', 'a', 'a']

print(array.all? { |item| item == 'a' })
print(array.my_all? { |item| item == 'a' })
