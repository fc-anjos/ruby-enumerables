module Enumerable
  def has_args?(*args)
    raise 'Too many arguments, there should be only one!' if args.length > 1
    return true unless args[0].nil?

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
      return true if self[i] == true
    end
    false
  end

  def my_all_class(expected_class)

    length.times do |i|
      next if self[i].is_a?(expected_class)

      return false
    end
    true

  end

  def my_all_regexp(expected_regexp)
    length.times do |i|
      next if self[i].match(expected_regexp)

      return false
    end
    true
  end

  def my_all_pattern(pattern)
    length.times do |i|
      next if self[i] == pattern

      return false
    end
    true
  end

  def my_all_argument(argument)
    return my_all_regexp(argument) if argument.is_a?(Regexp)

    return my_all_class(argument) if argument.is_a?(Class)

    my_all_pattern(argument)
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
    return to_enum unless block_given?

    selected = []
    length.times do |i|
      condition = yield self[i]
      selected.push(self[i]) if condition
    end
    selected
  end

  def my_all?(*args)
    return my_all_argument(args[0]) if has_args?(args)

    if block_given?
      length.times do |i|
        condition = yield self[i]
        next if condition

        return false
      end
      true

    elsif includes_nil_or_false?
      false

    else
      true
    end
  end

  # when a class is passed as an argument returns true if at least one of the collection is a member of such class
  # when a Regex is passed as an argument returns false if none of the collection matches the Regex
  # when a pattern other than Regex or a Class is given returns false if none of the collection matches the pattern
  def my_any_argument(argument)
    return my_any_regexp(argument) if argument.is_a?(Regexp)

    return my_any_class(argument) if argument.is_a?(Class)

    my_any_pattern(argument)
  end

  def my_any_regexp(expected_regexp)
    length.times do |i|
      next unless self[i].match(expected_regexp)

      return true
    end
    false
  end

  def my_any_pattern(pattern)
    length.times do |i|
      next unless self[i] == pattern

      return true
    end
    false
  end

  def my_any_class(expected_class)
    length.times do |i|
      next unless self[i].is_a?(expected_class)

      return true
    end
    false
  end

  def my_any?(*args)
    return my_any_argument(args[0]) if has_args?(args)


    if block_given?
      length.times do |i|
        condition = yield self[i]
        next unless condition

        return true
      end
      false

    elsif includes_not_nil_or_not_false?
      true

    else
      true
    end
  end

  # returns true if the block never returns true for all elements
  # When no block or argument is given returns true only if none of the collection members is true
  # When a pattern other than Regex or a Class is given returns true only if none of the collection matches the pattern
  # When a class is passed as an argument returns true if none of the collection is a member of such class
  # when a Regex is passed as an argument returns true only if none of the collection matches the Regex
  def my_none?
    length.times do |i|
      condition = yield self[i]
      next unless condition

      return true
    end
    false
  end

  # returns the number of items in enum through enumeration
  # counts the number of items in enum that are equal to item if an argument is given:
  def my_count
    count = 0
    length.times do |i|
      condition = yield self[i]
      next unless condition

      count += 1
    end
    count
  end

  # returns an enumerator if no block is Given
  # returns a new array with the results of running block once for every element in enum.
  def my_map(proc = nil)
    unless proc.nil?
      length.times do |i|
        # self[i] = proc.call(self[i])
      end
    end

    if block_given?
      length.times do |i|
        self[i] = yield(self[i])
      end
    end
    self
  end

  # When a symbol is specified combines each element of the collection by applying the symbol as a named method
  # Combines all elements of enum by applying a binary operation, specified by a block:
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
