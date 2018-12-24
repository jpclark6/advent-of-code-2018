input = File.read('./puzzle_txt/day_7.txt').split("\n").map{|line| [line.split[1], line.split[7]]}
require 'pry'

class Node
  attr_accessor :dependant, :it
  def initialize(pair)
    @it = pair[1]
    @dependant = pair[0]
  end
end

tryit = input.group_by { |a, b| a }
tryit = tryit.map do |letter, group|
  [letter, group.map { |ab| ab[1] }]
end

otherit = tryit.map do |letter, group|
  group
end
otherit = otherit.flatten
anotherit = otherit.group_by do |letter|
  letter
end
anotherit = anotherit.map do |letter, group|
  [letter, group.count]
end

# input.map! do |a, b|
#   Node.new([a, b])
# end

binding.pry













# def get_reply
#   first = ['I', 'You', 'She', 'He', 'They']
#   second = ['truley', 'really', 'never', 'always', 'barely']
#   third = ['cared', 'loved', 'wanted', 'jumped', 'laughed', 'painted']
#   fourth = ['at', 'in', 'around', 'between', 'under', 'over']
#   fifth = ['anything', 'you', 'her', 'at trees', 'dogs', 'cups', 'chairs']
#   finish = ['?', '!', '.', '.']
#
#   combos = [first, second, third, fourth, fifth]
#
#   reply = ""
#   combos.each do |word_set|
#     word = word_set[rand(word_set.length)]
#     reply << ' ' + word
#   end
#   reply << finish[rand(finish.length)]
#
#   reply
#
#   # 249381734 + 9528742732
# end
# # while true do
# loc = 0
# act_loc = 0
# 100.times do
#   start_time = Time.now
#   until Time.now > (start_time + 0.05)
#     loc += 1
#   end
#   act_loc += 1
#   print "#{act_loc}\t\t#{loc}\t\t"
#   puts get_reply
# end
