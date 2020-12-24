require 'set'

class Board
  def initialize
    @black = Set.new
  end

  def parse(str)
    coord = [0, 0]
    str.scan(/se|ne|e|sw|nw|w/).each do |dir|
      coord = neighbor(coord, dir)
    end
    if @black.include?(coord)
      @black.delete(coord)
    else
      @black.add(coord)
    end
  end

  def neighbor(coord, dir)
    y, x = coord
    dy, dx = case dir
             when 'nw'
               y.even? ? [1, -1] : [1, 0]
             when 'w'
               [0, -1]
             when 'sw'
               y.even? ? [-1, -1] : [-1, 0]
             when 'ne'
               y.even? ? [1, 0] : [1, 1]
             when 'e'
               [0, 1]
             when 'se'
               y.even? ? [-1, 0] : [-1, 1]
             else
               raise "Unexpected direction #{dir}"
             end
    [y + dy, x + dx]
  end

  def count_black
    @black.size
  end

  def flip
    white_tiles = Set.new
    flip_to_white = @black.filter do |coord|
      neighbors = neighbor_coordinates(coord)
      black, white = neighbors.partition { |nc| @black.include?(nc) }
      white_tiles.merge(white)
      black.empty? || black.size > 2
    end
    flip_to_black = white_tiles.filter do |coord|
      neighbors = neighbor_coordinates(coord)
      black, = neighbors.partition { |nc| @black.include?(nc) }
      black.size == 2
    end
    flip_to_white.each { |coord| @black.delete(coord) }
    @black.merge(flip_to_black)
  end

  def neighbor_coordinates(coord)
    %w[se ne e sw nw w].map { |dir| neighbor(coord, dir) }
  end
end

input = File.readlines('input.txt').map(&:chomp).freeze

board = Board.new

input.each { |line| board.parse(line) }

# Day 1
puts board.count_black

# Day 2
100.times { board.flip }
puts board.count_black
