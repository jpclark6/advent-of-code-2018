input = File.readlines('./puzzle_txt/day_3.txt')
input.map! { |line| line.chomp }

starting = Time.now

ary_size = 1001
grid = Array.new(ary_size) {Array.new(ary_size, 0)}

input.each do |line|
  split = line.split
  xy = split[2].split(",")
  x = xy[0].to_i
  y = xy[1].to_i
  dxdy = split[3].split("x")
  dx = dxdy[0].to_i
  dy = dxdy[1].to_i
  dx.times do |add_x|
    dy.times do |add_y|
      grid[y + add_y][x + add_x] += 1
    end
  end
end

part_1 = 0

grid.each do |lines|
  lines.each do |square|
    if square > 1
      part_1 += 1
    end
  end
end

middle = Time.now

# part 2
part_2 = ""

input.each do |line|
  unique = true
  split = line.split
  id = split[0].split('#')[1].to_i
  xy = split[2].split(",")
  x = xy[0].to_i
  y = xy[1].to_i
  dxdy = split[3].split("x")
  dx = dxdy[0].to_i
  dy = dxdy[1].to_i
  dx.times do |add_x|
    dy.times do |add_y|
      if grid[y + add_y][x + add_x] != 1
        unique = false
      end
    end
  end
  if unique == true
    part_2 = id
    break
  end
end

ending = Time.now


puts "Day3 Part1: #{part_1}\nDay3 Part2: #{part_2}"
puts "Day3 Total Time: #{ending - starting} seconds"
puts "Day3 Part1 time: #{middle - starting}"
puts "Day3 Part2 time: #{ending - middle}"
