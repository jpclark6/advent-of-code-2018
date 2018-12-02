input = File.readlines('./puzzle_txt/day_1.txt')
input.map! { |line| line.chomp.to_i }

starting = Time.now

answer_1 = input.reduce(0) { |line, sum| sum + line }

a1 = Time.now
after_1 = a1 - starting

repeat = false
sum = 0
z = 0
all_repeats = {}
answer_2 = 0

until repeat
  z += 1
  if z%1000 == 0
    puts "z at #{z}\t\tsum #{sum}"
  end
  input.each do |line|
    sum += line
    if all_repeats.has_key?(sum)
      answer_2 = sum
      repeat = true
      break
    else
      all_repeats[sum] = 0
    end
  end
end

ending = Time.now
after_2 = ending - a1

tot_time = ending-starting

puts "Answer to part 1: #{answer_1}\nAnswer to part 2: #{answer_2}"
puts "Total time: #{tot_time} seconds"
puts "Time for part 1: #{after_1}"
puts "Time for part 2: #{after_2}"
