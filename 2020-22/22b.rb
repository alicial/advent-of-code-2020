require 'set'

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

  def recursable?
    cards.size > top
  end

  def copy
    Deck.new(cards[1, top])
  end

  def play(deck)
    all_scores = Set.new
    loop do
      play_round(deck)
      scores = [score, deck.score]
      return scores if scores.any?(0)
      return [1, 0] if all_scores.include?(scores)
      all_scores.add(scores)
    end
  end

  def play_round(deck)
    if recursable? && deck.recursable?
      scores = copy.play(deck.copy)
      if scores[1].zero?
        take_top(deck)
      else
        deck.take_top(self)
      end
    elsif top > deck.top
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

scores = decks[0].play(decks[1])

puts scores.max
