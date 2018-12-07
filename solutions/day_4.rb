require 'pry'

input = File.readlines('./puzzle_txt/day_4.txt')
input.map! { |line| line.chomp }
starting = Time.now
input.sort!
prev_guard = ""
input.map! do |line|
  split_lines = line.split
  date = split_lines[0].split("-")
  date[0] = date[0][1..-1]
  year = date[0]
  month = date[1]
  day = date[2]
  time =split_lines[1][0..-2].split(":")
  hr = time[0]
  min = time[1]

  if split_lines[2] == "Guard"
    guard = split_lines[3][1..-1]
    prev_guard = guard
    status = split_lines[4]
  elsif split_lines[2] == "wakes"
    status = "wake"
    guard = prev_guard
  else
    status = "sleep"
    guard = prev_guard
  end

  [guard, status, min, hr, day, month, year]
end
sleep_times = []
input.each_with_index do |line, i|
  if line[1] == "sleep"
    sleep_times << [line[0], input[i + 1][2].to_i - input[i][2].to_i]
  end
end
min_per_guard = sleep_times.group_by do |guard, min|
  guard
end.to_a
min_per_guard = min_per_guard.map do |guard, data|
  asleep = data.sum { |a, b| b }
  [guard, asleep]
end
min_per_guard.map! {|a, b| [b, a]}
min_per_guard.sort!
max_guard = min_per_guard.last[1]

max_guard_schedule = input.select { |ind| ind[0] == max_guard && (ind[1] == "sleep" || ind[1] == "wake")}
max_guard_schedule.map! do |id, cycle, min, hr, day, m, y|
  ["#{y} #{m} #{day} #{hr} #{min}", min.to_i]
end
max_guard_schedule.sort!

all_minutes = []
(max_guard_schedule.length/2).times do |i|
  all_minutes << (max_guard_schedule[i*2][1]..(max_guard_schedule[i*2 + 1][1] - 1)).to_a
end
all_minutes.flatten!
all_sums = all_minutes.group_by { |min| min }.to_a.map { |min, mins| [mins.count, min] }.sort
part_1 = all_sums.last[1] * max_guard.to_i

middle = Time.now
# part 2
guard_times = input.group_by { |a, b, c, d, e, f, g, h| a }.to_a
guard_times.map! do |guard, schedule|
  sch = schedule.select { |ind| ind[1] == "sleep" || ind[1] == "wake" }
  if sch.empty?
    break
  end
  sch.map! do |id, cycle, min, hr, day, m, y|
    ["#{y} #{m} #{day} #{hr} #{min}", min.to_i]
  end
  sch.sort!
  all_minutes = []
  (sch.length/2).times do |i|
    all_minutes << (sch[i*2][1]..(sch[i*2 + 1][1] - 1)).to_a
  end
  all_minutes.flatten!
  all_sums = all_minutes.group_by { |min| min }.to_a.map { |min, mins| [mins.count, min] }.sort
  [all_sums.last[0], all_sums.last[1], guard]
end
guard_times = guard_times.select { |a| a[1].class == Integer }
top_guard = guard_times.sort.last
part_2 = top_guard[1] * top_guard[2].to_i

ending = Time.now

puts "Day5 Part1: #{part_1}\nDay5 Part2: #{part_2}"
puts "Day5 Total time: #{ending - starting} seconds"
puts "Day5 Part1 time: #{middle - starting}"
puts "Day5 Part2 time: #{ending - middle}"
