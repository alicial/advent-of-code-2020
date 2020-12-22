input = File.read('input.txt').split("\n\n")

class Deck
  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def empty?
    cards.empty?
  end

  def top
    cards.first
  end

  def play(deck)
    if top > deck.top
      take_top(deck)
    else
      deck.take_top(self)
    end
  end

  def take_top(deck)
    cards.rotate!
    cards << deck.cards.shift
  end

  def score
    return 0 if empty?

    cards.reverse.each_with_index.reduce(0) { |sum, (v, i)| sum += (v * (i + 1)) }
  end
end

cards = input.map do |lines|
  lines.split("\n")[1..].map(&:to_i)
end

decks = cards.map { |c| Deck.new(c) }

decks[0].play(decks[1]) until decks[0].empty? || decks[1].empty?

puts decks.map(&:score).max
