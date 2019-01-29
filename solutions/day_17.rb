require 'pry'

class Clay
  attr_accessor :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end
end

class Ground
  attr_accessor :ground

  def initialize(ground)
    @ground = ground
    @water = {x: 500, y: 0}
  end
end

ground = []
text=File.open('./puzzle_txt/day_17_ex.txt').read
text.gsub!(/\r\n?/, "\n")
text.each_line do |line|
  line = line.chomp
  line = line.split(", ")
  type, x, y = '', nil, nil
  clay = line[0].split("=")
  if clay[0] == 'x'
    x = clay[1].to_i
  else
    y = clay[1].to_i
  end
  clay = line[1].split("=")
  if clay[0] == 'x'
    x1 = clay[1].split('..')[0].to_i
    x2 = clay[1].split('..')[0].to_i
  else
    y1 = clay[1].split('..')[0].to_i
    y2 = clay[1].split('..')[1].to_i
  end
  if x
    (y1..y2).each do |y|
      ground << Clay.new(x, y)
    end
  else
    (x1..x2).each do |x|
      ground << Clay.new(x, y)
    end
  end
end


binding.pry
