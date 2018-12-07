require 'set'
require 'pry';

input = File.readlines('./puzzle_txt/day_2.txt')
input.map! { |line| line.chomp }

starting = Time.now

# part 1
twos = 0
threes = 0

input.each do |line|
  ary = Hash.new(0)
  line.chars.each do |char|
    ary[char] += 1
  end
  repeat_3 = false
  repeat_2 = false
  ary.each do |a, num|
    if num == 3
      unless repeat_3
        threes += 1
        repeat_3 = true
      end
    elsif num == 2
      unless repeat_2
        twos += 1
        repeat_2 = true
      end
    end
  end
end

checksum = threes * twos

middle = Time.now

# part 2
first_set = Hash.new()
second_set = Hash.new()
answer_part_2 = ""

def check?(line_1, line_2)
  count = 0
  line_1.chars.each_with_index do |char, i|
    if char == line_2[i]
      count += 1
    end
    if count == line_1.length - 1
      return true
    end
  end
  false
end

def get_answer(p1, p2)
  if p1 == "qyszphxoiseldjrntfygvdmanu" || p2 == "qyszphxoiseldjrntfygvdmanu"
    x = "qywzphxoiseldjrntfygvdmanu"
    binding.pry
  end
  answer_2 = ""
  p1.chars.each_with_index do |char, i|
    if char == p2.chars[i]
      answer_2 << char
    end
  end
  answer_2
end

# 2.times do
# input.each do |line|
#   first_half = line[0..12]
#   second_half = line[13..-1]
#
#   if first_set.has_key? first_half
#     if check?(first_set[first_half], line)
#       answer_part_2 = get_answer(first_set[first_half], line)
#       break
#     end
#   elsif second_set.has_key? second_half
#     if check?(second_set[second_half], line)
#       answer_part_2 = get_answer(second_set[second_half], line)
#       break
#     end
#   else
#     first_set[first_half] = line
#     second_set[second_half] = line
#   end
# end
# end

# part_2 = [line, test] unless line == test

#
#
part_2 = []

count = 0
input.each do |line|
  input.each do |test|
    count = 0
    test.chars.each_with_index do |char, i|
      if char == line[i]
        count += 1
      end
      if count == line.length - 1
        part_2 = [line, test] unless line == test
      end
    end
  end
end
# binding.pry

answer_2 = ""
part_2[0].chars.each_with_index do |char, i|
  if char == part_2[1].chars[i]
    answer_2 << char
  end
end

ending = Time.now


puts "Day2 Part1: #{checksum}\nDay2 Part2: #{answer_2}"
puts "Day2 Total Time: #{ending - starting} seconds"
puts "Day2 Part1 time: #{middle - starting}"
puts "Day2 Part2 time: #{ending - middle}"
