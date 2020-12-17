input = File.readlines('input.txt').freeze

actives = {}

input.each_with_index do |row, y|
  row.chars.each_with_index do |cube, x|
    actives[[x, y, 0, 0]] = true if cube == '#'
  end
end

# Directions to find every neighbor given a coordinate
DIRECTIONS = (-1..1).map do |x|
  (-1..1).map do |y|
    (-1..1).map do |z|
      (-1..1).map do |w|
        [x, y, z, w]
      end
    end
  end
end.flatten(3)
DIRECTIONS.delete([0, 0, 0, 0])

# Count number of active neighbors up to `count_to`
def count_active_neighbors(coord, grid, count_to)
  count = 0
  DIRECTIONS.each do |dir|
    x, y, z, w = coord
    dx, dy, dz, dw = dir
    x += dx
    y += dy
    z += dz
    w += dw
    if grid.key?([x, y, z, w])
      count += 1 if grid[[x, y, z, w]]
      break if count > count_to
    end
  end
  count
end

# Get all the neighbors of the active cubes and mark them false
def generate_grid(actives)
  grid = {}
  actives.each do |coord, _|
    grid[coord] = true
    DIRECTIONS.each do |dir|
      x, y, z, w = coord
      dx, dy, dz, dw = dir
      grid[[x + dx, y + dy, z + dz, w + dw]] = false unless grid[[x + dx, y + dy, z + dz, w + dw]]
    end
  end
  grid
end

# Look at the actives and their neighbors to figure out which cubes are
# active in the next iteration
i = 0
while i < 6
  grid = generate_grid(actives)
  next_actives = {}
  grid.each do |coord, active|
    active_neighbors = count_active_neighbors(coord, actives, 4)
    if (active && [2, 3].include?(active_neighbors)) ||
       (!active && active_neighbors == 3)
      next_actives[coord] = true
    end
  end
  actives = next_actives
  i += 1
end

puts actives.size
