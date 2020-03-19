module Enumerable
  def args?(*args)
    raise 'Too many arguments, there should be only one!' if args.length > 1
    return true unless args[0].empty?

    false
  end

  def includes_not_nil_or_not_false?
    length.times do |i|
      true if self[i] != false || !self[i].nil?
    end
    false
  end

  def includes_nil_or_false?
    length.times do |i|
      return true if self[i] == false || self[i].nil?
    end
    false
  end

  def includes_true?
    length.times do |i|
      return true if self[i]
    end
    return false
  end

  def my_all_argument(argument)
    length.times do |i|
      case argument
      when Class
        next if self[i].is_a?(argument)
      when Regexp
        next if self[i].match(argument)
      else
        next if self[i] == argument
      end
      return false
    end
    true
  end
end

module Enumerable
  def my_each
    return to_enum unless block_given?

    length.times do |i|
      yield(self[i])
    end
    self
  end

  def my_each_with_index
    if block_given?
      length.times do |i|
        yield self[i], i
      end
      self
    else
      a = []
      length.times do |i|
        a.push [self[i], i]
    end
      return a.to_enum
    end
  end

  def my_select
    return to_enum unless block_given?

    selected = []
    length.times do |i|
      condition = yield self[i]
      selected.push(self[i]) if condition
    end
    selected
  end

  def my_all?(*args)
    return my_all_argument(args[0]) if args?(args)

    if block_given?
      length.times do |i|
        condition = yield self[i]
        next if condition

        return false
      end
      true

    elsif includes_true?
      return true
    else
      true
    end
  end
end
module Enumerable
  def my_any_argument(argument)
    length.times do |i|
      case argument
      when Class
        next unless self[i].is_a?(argument)
      when Regexp
        next unless self[i].match(argument)
      else
        next unless self[i] == argument
      end
      return true
    end
    false
  end

  def my_any?(*args)
    return my_any_argument(args[0]) if args?(args)

    if block_given?
      length.times do |i|
        condition = yield(self[i])
        next unless condition

        return true
      end
      false

    elsif includes_true?
      true

    else
      false
    end
  end

  def my_count(*args)
    return my_count_argument(args[0]) if args?(args)

    return self.length unless block_given?

    count = 0
    length.times do |i|
      condition = yield self[i]
      next unless condition

      count += 1
    end
    count
  end

  def my_count_argument(argument)
    count = 0
    length.times do |i|
      case argument
      when Class
        next unless self[i].is_a?(argument)
      when Regexp
        next unless self[i].match(argument)
      else
        next unless self[i] == argument
      end
      count += 1
    end
    count
  end

  def my_map(proc = nil)
    return to_enum unless block_given?

    array = []
    unless proc.nil?
      length.times do |i|
        array.push proc.call(self[i])
      end
    end

    length.times do |i|
      array.push yield(self[i])
    end
    array
  end

  def my_inject(start = nil, symbol = nil, &block)

    array = if is_a?(Range)
              to_a
            else
              self
            end

    block = symbol.to_proc if symbol.is_a?(Symbol)

    accumulated = if start.nil?
                    array[0]
                  else
                    block.yield(start, array[0])
                  end

    array.length.times do |i|
      next if i.zero?

      accumulated = block.yield(accumulated, array[i])
    end
    accumulated
  end

  def multiply_els
    my_inject { |result, element| result * element }
  end
end
module Enumerable
  def my_none_argument(argument)
    length.times do |i|
      case argument
      when Class
        next unless self[i].is_a?(argument)
      when Regexp
        next unless self[i].match(argument)
      else
        next unless self[i] == argument
      end
      return false
    end
    true
  end

  def my_none?(*args)
    return my_none_argument(args[0]) if args?(args)

    if block_given?
      length.times do |i|
        condition = yield(self[i])
        next unless condition

        return false
      end
      true

    elsif includes_true?
      false

    else
      true
    end
  end
end

# my_count is returning nil instead of the number of elements in the enum when no block or argument is given.

a = [1, 2, 3]


