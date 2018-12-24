require 'pry'

input = "1, 1
1, 6
8, 3
3, 4
5, 5
8, 9"

input = input.split("\n")
input = input.map { |line| [line.split(", ")[0].to_i, line.split(", ")[1].to_i]}
expected = 17

def find_grid(input)
  max_x = input.max_by { |a, b| a }[0]
  max_y = input.max_by { |a, b| b }[1]
  [max_x, max_y]
end

def find_distance(x1, y1, x2, y2)
  (x1 - x2).abs + (y1 - y2).abs
end

def manhattan_distance(grid, x, y)
  streets = Array.new(grid.length) { Array.new(grid[0].length) }
  grid.length.times do |column|
    grid[0].length.times do |row|
      streets[column][row] = find_distance(x, y, row, column)
    end
  end
  streets
end

def print_grid(grid)
  grid.each do |row|
    row.each do |column|
      print "#{column} "
      print " " if column < 10
    end
    print "\n"
  end
end

max_x = find_grid(input)[0] + 2
max_y = find_grid(input)[1] + 2

grid = Array.new(max_y) {Array.new(max_x)}

grid_with_highs = grid.map do |column|
  column.map do |row|
    d = Hash.new
    d[:distance] = 1000
  end
end

min_grid = Array.new(max_y) {Array.new(max_x)}
min_grid.each_with_index do |column, i|
  column.each_with_index do |row, j|
    min_grid[i][j] = {distance: 1000, entry: -1}
  end
end

each_input_with_dist = input.map do |x, y|
  ans = manhattan_distance(grid, x, y)
  ans
end

each_input_with_dist.each_with_index do |single_grid, entry|
  single_grid.each_with_index do |row, y|
    row.each_with_index do |num, x|
      if num < min_grid[y][x][:distance]
        min_grid[y][x][:distance] = num
        min_grid[y][x][:entry] = entry
      elsif num > min_grid[y][x][:distance]

      elsif num == min_grid[y][x][:distance]
        min_grid[y][x][:distance] = -1
        min_grid[y][x][:entry] = -1
      end
    end
  end
end

def possible_answer(a_grid, entry_try)
  return_answer = a_grid.inject(0) do |sum, row|
    sum + row.count { |o_row| o_row[:entry] == entry_try && o_row[:distance] >= 0 }
  end
  return_answer
end

input.each_with_index do |inpu, i|
  puts i
  puts possible_answer(min_grid, i)
  puts
end


binding.pry


# max_x.times do |x|
#   max_y.times do |y|
#     grid[y][x] = 1
#   end
# end



# new_round = []
#
# grid.each do |y|
#   grid[y].each do |x|
#
#   end
# end
#
# require 'pry'
# points = File.readlines('./puzzle_txt/day_6.txt').map { |line| line.strip.split(', ').map(&:to_i) }
# x0 = 0
# y0 = 0
# xmax = points.collect { |x| x[0] }.max
# ymax = points.collect { |x| x[1] }.max
#
# def manhattan(pt1, pt2)
#   (pt1[0] - pt2[0]).abs + (pt1[1] - pt2[1]).abs
# end
#
# def find_closest(points, xxx, yyy)
#   closest_for_point = points.each_with_index
#                             .map { |point, index| [index, manhattan([xxx, yyy], point)] }
#                             .sort_by { |_xxxx, yyyy| yyyy }.first(2)
#   closest_for_point.first[1] == closest_for_point.last[1] ? false : closest_for_point.first
# end
#
# distances = []
#
# binding.pry
# (x0..xmax).each do |x|
#   (y0..ymax).each do |y|
#     distances[x] ||= []
#     closest = find_closest(points, x, y)
#     closest ? distances[x][y] = closest[0] : 'x'
#   end
# end
#
# def infinite?(distances, points, id, xmax, ymax)
#   return if id.nil?
#
#   x, y = points[id]
#   [distances[0][y], distances[x][0], distances[0][ymax], distances[xmax][0]].include?(id)
# end
#
# results = distances.clone.flatten
#                    .group_by(&:itself).transform_values(&:count)
#                    .delete_if { |id, _count| infinite?(distances, points, id, xmax, ymax) }
#
# puts results.sort_by { |_x, y| y }.inspect # Take highest non-nil-index count
#
# #-------PART 2--------
#
# def sum_closest(points, xxx, yyy)
#   points.inject(0) { |sum, point| sum + manhattan(point, [xxx, yyy]) } < 10_000
# end
#
# answers = []
#
# (x0..xmax).each do |x|
#   (y0..ymax).each do |y|
#     answers << [x, y] if sum_closest(points, x, y)
#   end
# end
#
# puts answers.count
