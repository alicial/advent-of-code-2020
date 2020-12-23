Cup = Struct.new(:val, :next) do
end

class Circle
  attr_accessor :cups, :current

  def initialize(arr, part2 = false)
    @max = arr.max
    @min = arr.min

    @cups = {}
    node = nil

    if part2
      n = @max
      @max = 1_000_000
      i = @max
      while i > n
        node = Cup.new(i, node)
        @cups[i] = node
        i -= 1
      end
    end

    arr.reverse.each do |i|
      node = Cup.new(i, node)
      @cups[i] = node
    end

    if part2
      @cups[@max].next = node
    else
      @cups[arr.last].next = node
    end
    @current = node
  end

  def move(num)
    num.times do
      move_cups
    end
  end

  def move_cups
    removed = []
    head = @current.next
    node = head
    tail = nil
    3.times do
      removed << node.val
      tail = node
      node = node.next
    end
    @current.next = node
    destination = find_next_cup(removed)
    insert_before = destination.next
    destination.next = head
    tail.next = insert_before
    @current = @current.next
  end

  def find_next_cup(removed)
    c = @current.val - 1
    c = @max if c < @min
    while removed.include?(c)
      c -= 1
      c = @max if c < @min
    end
    cups[c]
  end
end

input = '487912365'
arr = input.split('').map(&:to_i)

# Part 1
circle = Circle.new(arr)
circle.move(100)

node = circle.cups[1]
puts (arr.size - 1).times.map { node = node.next; node.val }.join('')

# Part 2
circle = Circle.new(arr, true)
circle.move(10_000_000)

cup = circle.cups[1].next
puts cup.val * cup.next.val
