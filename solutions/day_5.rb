require 'pry'
input = File.read('./puzzle_txt/day_5.txt').chomp
# input = 'dabAcCaCBAcCcaDA'
starting = Time.now

def alpha
  alpha_hash = {}
  lower.each_with_index do |l, i|
    alpha_hash[l] = upper[i]
  end
  alpha_hash
end

def upper
  ('A'..'Z').to_a
end

def lower
  ('a'..'z').to_a
end

def alchemy(chain)
  alpha.to_a.each do |p1, p2|
    chain = chain.gsub("#{p1}#{p2}", "")
    chain = chain.gsub("#{p2}#{p1}", "")
  end
  chain
end

def answer_loop(chain)
  same = false
  new_chain = ""
  until same
    new_chain = alchemy(chain)
    same = chain.length == new_chain.length ? true : false
    chain = new_chain
  end
  new_chain.length
end

part_1 = answer_loop(input)

middle = Time.now

# part 2
alphabet = ("a".."z").to_a
cloned_input = input.dup
answer = alphabet.map do |letter|
  new_input = cloned_input.gsub(/["#{letter}#{letter.upcase}"]/, "")
  answer_loop(new_input)
end

part_2 = answer.min

ending = Time.now

puts "Day5 Part1: #{part_1}\nDay5 Part2: #{part_2}"
puts "Day5 Total time: #{ending - starting} seconds"
puts "Day5 Part1 time: #{middle - starting}"
puts "Day5 Part2 time: #{ending - middle}"
