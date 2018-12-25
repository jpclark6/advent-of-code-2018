require "pry"

class Point
  attr_accessor :pos_x, :pos_y, :vel_x, :vel_y
  def initialize(pos_x, pos_y, vel_x, vel_y)
    @pos_x = pos_x
    @pos_y = pos_y
    @vel_x = vel_x
    @vel_y = vel_y
  end

  def move
    @pos_x += @vel_x
    @pos_y += @vel_y
  end

  def move_back
    @pos_x -= @vel_x
    @pos_y -= @vel_y
  end
end

class Sky
  attr_accessor :points
  def initialize(points)
    @points = points
    @total_time = 0
  end

  def find_mins(points)
    max_x = points.max_by { |point| point.pos_x}
    min_x = points.min_by { |point| point.pos_x}
    max_y = points.max_by { |point| point.pos_y}
    min_y = points.min_by { |point| point.pos_y}
    [max_x.pos_x - min_x.pos_x, max_y.pos_y - min_y.pos_y]
  end

  def find_solution
    min_x = find_mins(@points)[0]
    min_y = find_mins(@points)[1]
    current_min_x = Float::INFINITY
    current_min_y = Float::INFINITY

    until min_x > current_min_x || min_y > current_min_y
      current_min_x, current_min_y = min_x, min_y
      @points.each { |point| point.move }
      @total_time += 1
      min_x = find_mins(@points)[0]
      min_y = find_mins(@points)[1]
    end
    map_sky
    @points.each { |point| point.move_back }
    @total_time -= 1
    map_sky
  end

  def find_min_x
    points.min_by { |point| point.pos_x}
  end

  def find_min_y
    points.min_by { |point| point.pos_y}
  end

  def find_max_x
    points.max_by { |point| point.pos_x}
  end

  def find_max_y
    points.max_by { |point| point.pos_y}
  end

  def map_sky
    grid = Array.new(find_max_y.pos_y - find_min_y.pos_y + 3) { Array.new(find_max_x.pos_x - find_min_x.pos_x + 3, ' ') }
    min_x = find_min_x
    min_y = find_min_y
    @points.each do |point|
      grid[point.pos_y - min_y.pos_y + 1][point.pos_x - min_x.pos_x + 1] = '#'
    end
    grid.each do |row|
      p row.join
    end
    puts "Answer in #{@total_time} seconds"
  end
end

points = []
line_num=0
text=File.open('./puzzle_txt/day_10.txt').read
text.gsub!(/\r\n?/, "\n")
text.each_line do |line|
  line_text = line.split(/[<>]/)
  x = line_text[1].split(",")
  v = line_text[3].split(",")
  points << Point.new(x[0].to_i, x[1].to_i, v[0].to_i, v[1].to_i)
end
sky = Sky.new(points)
sky.find_solution
