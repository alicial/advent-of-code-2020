Cup = Struct.new(:val, :next) do
end

class Circle
  attr_accessor :cups, :current

  def initialize(arr)
    node = nil
    @cups = {}
    arr.reverse.each do |i|
      node = Cup.new(i, node)
      @cups[i] = node
    end
    @max = arr.max
    @min = arr.min

    @cups[arr.last].next = node
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

circle = Circle.new(arr)
circle.move(100)

node = circle.cups[1]
puts (arr.size - 1).times.map { node = node.next; node.val }.join('')
