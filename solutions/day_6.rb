require 'pry'

input = File.read('./puzzle_txt/day_6.txt')
input = input.split("\n").map { |line| [line.split(", ")[0].to_i, line.split(", ")[1].to_i]}

def find_grid_dims(input)
  [input.max_by { |a, b| a }[0], input.max_by { |a, b| b }[1]]
end

def find_manhattan_distance(x1, y1, x2, y2)
  (x1 - x2).abs + (y1 - y2).abs
end

def grid_with_distances(grid, x, y, index)
  streets = Array.new(grid.length) { Array.new(grid[0].length) }
  grid.length.times do |column|
    grid[0].length.times do |row|
      streets[column][row] = {index => find_manhattan_distance(x, y, row, column)}
    end
  end
  streets
end

max_x = find_grid_dims(input)[0] + 2
max_y = find_grid_dims(input)[1] + 2

grid =  Array.new(max_y) {Array.new(max_x, {0 => 1000})}

each_input_with_dist = input.map.with_index do |xy, i|
  grid_with_distances(grid, xy[0], xy[1], i)
end

each_input_with_dist.each_with_index do |one_grid, i|
  one_grid.each_with_index do |one_row, y|
    one_row.each_with_index do |one_loc, x|
      if grid[y][x].values[0] > one_loc.values[0]
        grid[y][x] = 0
        grid[y][x] = one_loc
      elsif grid[y][x].values[0] == one_loc.values[0]
        grid[y][x] = {500 => one_loc.values[0]}
      end
    end
  end
end

def edge?(loc, grid)
  edges = []
  grid[0].each { |key| edges << key.keys.first }
  grid[-1].each { |key| edges << key.keys.first }
  (0...grid.length).each do |i|
    edges << grid[i][0].keys.first
    edges << grid[i][-1].keys.first
  end
  edges.include?(loc)
end

flat_grid = grid.flatten
answer = flat_grid.group_by { |hash| hash.keys.first }
                  .map { |key, val| [val.length, key] }
                  .sort
                  .reverse
                  .find { |value, loc| edge?(loc, grid) == false }
                  .first
binding.pry
puts "Part 1 answer: #{answer}"

distance_grid = grid.map.with_index do |row, i|
  row.map.with_index do |loc, j|
    distance_to_all = 0
    input.each do |x, y|
      distance_to_all += find_manhattan_distance(x, y, i, j)
    end
    distance_to_all
  end
end

answer_2 = distance_grid.flatten.count { |loc| loc < 10000 }

puts "Part 2 answer: #{answer_2}"
