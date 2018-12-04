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

answer_2 = ""
part_2[0].chars.each_with_index do |char, i|
  if char == part_2[1].chars[i]
    answer_2 << char
  end
end

ending = Time.now


puts "Day1 Part1: #{checksum}\nDay1 Part2: #{answer_2}"
puts "Total part1: #{ending - starting} seconds"
puts "Day1 Part1 time: #{middle - starting}"
puts "Day2 Part2 time: #{ending - middle}"
