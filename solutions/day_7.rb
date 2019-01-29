# input = File.read('./puzzle_txt/day_7.txt').split("\n").map{|line| [line.split[1], line.split[7]]}
# require 'pry'
#
# class Node
#   attr_accessor :visited, :value, :prereqs
#
#   def initialize(value, prereq)
#     @value = value
#     @visited = false
#     @prereqs = []
#     @prereqs << prereq if prereq
#   end
# end
#
# class Tree
#   attr_accessor :nodes, :stack, :path
#
#   def initialize
#     @nodes = []
#     @stack = []
#     @path = []
#     @node = nodes.first
#   end
#
#   def find_parents(node)
#     @nodes.select { |n| node.prereqs.include?(n.value) && n.visited == false }
#   end
#
#   def find_stack
#     while true do
#       @node = @nodes.select { |node| node.prereqs.empty? && node.visited == false }
#                     .sort_by { |node| node.value }
#                     .first
#       if @node
#         @node.visited = true
#         @nodes.each { |node| node.prereqs.delete(@node.value) }
#         @stack << @node.value
#       else
#         return @stack
#       end
#     end
#   end
# end
#
# tree = Tree.new
# input.each do |prereq, value|
#   if node = tree.nodes.find { |node| node.value == value }
#     node.prereqs << prereq
#   else
#     tree.nodes << Node.new(value, prereq)
#   end
# end
# input.each do |prereq, value|
#   unless tree.nodes.find { |node| node.value == prereq }
#     tree.nodes << Node.new(prereq, nil)
#   end
# end
#
# puts "Answer is #{tree.find_stack.join}"
input = File.read('./puzzle_txt/day_7.txt').split("\n").map{|line| [line.split[1], line.split[7]]}
require 'pry'

class Node
  attr_accessor :visited, :value, :prereqs, :timer, :active, :queued

  def initialize(value, prereq)
    @value = value
    @visited = false
    @prereqs = []
    @prereqs << prereq if prereq
    @active = false
    @timer = 60 + alpha_delay[value]
    @queued = false
  end

  def alpha_delay
    alpha = ('A'..'Z')
    numeric = (1..26)
    alpha.zip(numeric).to_h
  end
end

class Tree
  attr_accessor :nodes, :stack, :path

  def initialize
    @nodes = []
    @stack = []
    @path = []
    @node = nodes.first
  end

  def find_parents(node)
    @nodes.select { |n| node.prereqs.include?(n.value) && n.visited == false }
  end

  def find_stack
    num_workers = 5
    current_time = 0
    available_workers = num_workers
    passover_available_nodes = []

    while true do
      @available_nodes = @nodes.select do |node|
        node.prereqs.empty? &&
        node.visited == false &&
        node.active == false &&
        node.queued == false
      end
      @available_nodes.each do |node|
        node.queued = true
        passover_available_nodes << node
      end
      passover_available_nodes = passover_available_nodes.sort_by { |node| node.value }
      new_passover_available_nodes = []
      if available_workers >= passover_available_nodes.length
        passover_available_nodes.each do |node|
          node.active = true
          available_workers -= 1
        end
      else
        current_workers = available_workers
        passover_available_nodes.each_with_index do |node, index|
          if index < current_workers
            node.active = true
            available_workers -= 1
          else
            node.queued = true
            new_passover_available_nodes << node
          end
        end
      end
      passover_available_nodes = new_passover_available_nodes
      @nodes.each do |node|
        if node.active == true
          node.timer -= 1
        end
      end
      @nodes.each do |node|
        if node.timer == 0 && node.active == true
          @nodes.each { |node_2| node_2.prereqs.delete(node.value) }
          @stack << node.value
          node.visited = true
          node.active = false
          available_workers += 1
        end
      end
      current_time += 1
      if @nodes.all? { |node| node.visited == true }
        return current_time
      end
    end
  end
end

tree = Tree.new
input.each do |prereq, value|
  if node = tree.nodes.find { |node| node.value == value }
    node.prereqs << prereq
  else
    tree.nodes << Node.new(value, prereq)
  end
end
input.each do |prereq, value|
  unless tree.nodes.find { |node| node.value == prereq }
    tree.nodes << Node.new(prereq, nil)
  end
end

puts "Answer is #{tree.find_stack}"
