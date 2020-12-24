class Board
  def initialize
    @black = {}
  end

  def parse(str)
    coord = [0, 0]
    str.scan(/se|ne|e|sw|nw|w/).each do |dir|
      coord = neighbor(coord, dir)
    end
    if @black.key?(coord)
      @black.delete(coord)
    else
      @black[coord] = true
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
end

input = File.readlines('sample.txt').map(&:chomp).freeze

board = Board.new

input.each { |line| board.parse(line) }

puts board.count_black
