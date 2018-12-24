require 'pry'

padding_amount = 300
padding = '.' * padding_amount

initial = File.readlines('./puzzle_txt/input_12.txt')[0].chomp
# initial = File.readlines('./puzzle_txt/ex_12.txt')[0].chomp
initial_state = Array.new
initial_state[0] = padding + initial + padding
keys = File.readlines('./puzzle_txt/input_12.txt')[2..-1].map{ |line| line.chomp }.map{ |line| [line.split(" => ")[0], line.split(" => ")[1]]}
# keys = File.readlines('./puzzle_txt/ex_12.txt')[2..-1].map{ |line| line.chomp }.map{ |line| [line.split(" => ")[0], line.split(" => ")[1]]}
keys = keys.to_h

# Part 1
20.times do |i|
  initial_state[i + 1] = ".."
  initial_state[i].chars.each_cons(5) do |state|
    if keys.has_key?(state.join)
      initial_state[i + 1] += keys[state.join]
    else
      initial_state[i + 1] += "."
    end
  end
  initial_state[i + 1] += ".."
end

new_num = 0
initial_state.each_with_index do |line, i|
  line.chars.each_with_index do |char, j|
    new_num += j - padding_amount if (char == "#" && i == 20)
  end
end

part_1 = new_num
puts "Part 1: #{part_1}"

# Part 2

padding_amount = 300
padding = '.' * padding_amount

initial = File.readlines('./puzzle_txt/input_12.txt')[0].chomp
# initial = File.readlines('./puzzle_txt/ex_12.txt')[0].chomp
initial_state = Array.new
initial_state[0] = padding + initial + padding
keys = File.readlines('./puzzle_txt/input_12.txt')[2..-1].map{ |line| line.chomp }.map{ |line| [line.split(" => ")[0], line.split(" => ")[1]]}
# keys = File.readlines('./puzzle_txt/ex_12.txt')[2..-1].map{ |line| line.chomp }.map{ |line| [line.split(" => ")[0], line.split(" => ")[1]]}
keys = keys.to_h

200.times do |i|
  initial_state[i + 1] = ".."
  initial_state[i].chars.each_cons(5) do |state|
    if keys.has_key?(state.join)
      initial_state[i + 1] += keys[state.join]
    else
      initial_state[i + 1] += "."
    end
  end
  initial_state[i + 1] += ".."
end


prev = 0
200.times do |i|
  new_num = 0
  initial_state[i].chars.each_with_index do |char, j|
    new_num += j - padding_amount if (char == "#")
  end
  # puts "#{i}\t-\t#{new_num}\tnew - prev\t#{new_num - prev}"
  prev = new_num
end

# common thread is after row 185 each line increases by 42
# at row 200 it's equal to 9568, so then add 42 * remaining amount
puts "Part 2: #{9568 + (50000000000-200)*42}"




# binding.pry
