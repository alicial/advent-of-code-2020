tiles_str = File.read('input.txt').split("\n\n")

class Tile
  attr_accessor :id, :edges

  def initialize(id, edges)
    @id = id
    @edges = edges
  end

  def corner?(potential_neighbors)
    borders = @edges.filter do |edge|
      neighbors = potential_neighbors.filter do |tile|
        tile.edges.include?(edge) || tile.edges.map(&:reverse).include?(edge)
      end
      neighbors.empty?
    end
    borders.length == 2
  end
end

tiles = tiles_str.map do |str|
  lines = str.split("\n")
  id = lines[0].scan(/Tile (\d+):/).first.first

  left = lines[1..].map {|l| l[0]}.join.reverse
  right = lines[1..].map {|l| l[-1]}.join

  edges = [lines[1], right, lines.last.reverse, left]
  Tile.new(id, edges)
end

corners = tiles.filter { |tile| tile.corner?(tiles - [tile]) }

puts corners.reduce(1) { |acc, tile| acc * tile.id.to_i }