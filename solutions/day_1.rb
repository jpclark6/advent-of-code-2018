input = File.readlines('./puzzle_txt/day_1.txt')
input.map! { |line| line.chomp.to_i }

starting = Time.now
answer_1 = 0
answer_2 = 0

answer_1 = input.reduce(0) { |line, sum| sum + line }

freq = 0
a1 = Time.now
after_1 = a1 - starting

repeat = false
all_freq = {}

until repeat
  input.each do |line|
    freq += line
    if all_freq.has_key?(freq)
      answer_2 = freq
      repeat = true
      break
    else
      all_freq[freq] = 0
    end
  end
end

ending = Time.now
after_2 = ending - a1

tot_time = ending-starting

puts "Day1 Part1: #{answer_1}\nDay1 Part2: #{answer_2}"
puts "Total part1: #{tot_time} seconds"
puts "Day1 Part1 time: #{after_1}"
puts "Day2 Part2 time: #{after_2}"
