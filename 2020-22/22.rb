input = File.read('input.txt').split("\n\n")

Node = Struct.new(:val, :next) do
end

class Deck
  attr_accessor :head, :tail
  
  def initialize(head)
    @head = head
    node = head
    while !node.next.nil?
      node = node.next
    end
    @tail = node
  end

  def empty?
    head.next.nil?
  end

  def top
    empty? ? nil : head.next.val
  end

  def play(deck)
    if top > deck.top
      take_top(deck)
    else
      deck.take_top(self)
    end
  end

  def pop
    node = head.next
    head.next = node.next
    node
  end

  def take_top(deck)
    mine = self.pop
    theirs = deck.pop
    theirs.next = nil
    mine.next = theirs
    @tail.next = mine
    @tail = theirs
  end

  def score
    return 0 if empty?
    arr = []
    node = head.next
    while !node.nil?
      arr << node.val
      node = node.next
    end
    arr.reverse.each_with_index.reduce(0) {|sum, (v, i)| sum += (v * (i+1)) }
  end
end


decks = input.map do |lines|
  next_node = nil
  lines.split("\n")[1..].reverse.each do |card|
    next_node = Node.new(card.to_i, next_node)
  end
  head = Node.new(:head, next_node)
  Deck.new(head)
end

until decks[0].empty? || decks[1].empty? do
  decks[0].play(decks[1])
end

puts decks.map(&:score).max


