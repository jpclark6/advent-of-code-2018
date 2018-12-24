require 'pry'
require 'colorize'

input = File.read('./puzzle_txt/day_13.txt')

def direction
  {'^' => [0, -1],
    '>'  => [1, 0],
    'v' => [0, 1],
    '<' => [-1, 0],
    'up' => [0, -1],
    'right' => [1, 0],
    'down' => [0, 1],
    'left' => [-1, 0]}
end

def find_carts(paths)
  cart = 0
  cart_array = []
  active_carts = []
  paths.split("\n").each_with_index do |line, y|
    line.chars.each_with_index do |char, x|
      if char =~ /[<>^v]/
        cart_array << {cart_num: cart, loc: [x, y], dir: direction[char], intersections: 0}
        active_carts << cart
        cart += 1
      end
    end
  end
  {carts: cart_array, active_carts: active_carts}
end

cart_info = find_carts(input)

def turn_right(direction)
  if direction == [0, -1]
    return [1, 0]
  elsif direction == [1, 0]
    return [0, 1]
  elsif direction == [0, 1]
    return [-1, 0]
  else
    return [0, -1]
  end
end

def turn_left(direction)
  if direction == [0, -1]
    return [-1, 0]
  elsif direction == [1, 0]
    return [0, -1]
  elsif direction == [0, 1]
    return [1, 0]
  else
    return [0, 1]
  end
end

def order_carts(carts)
  carts.sort_by { |cart| [cart[:loc][1], cart[:loc][0]] }
end

def move_forward(cart_info, input)
  active_carts = cart_info[:active_carts]
  carts = order_carts(cart_info[:carts])

  old_carts = Marshal.load( Marshal.dump(carts) )

  old_carts.each_with_index do |cart, i|
    cart_direction = cart[:dir]
    intersections = cart[:intersections]
    next_loc = [cart[:loc][0] + cart[:dir][0], cart[:loc][1] + cart[:dir][1]]

    # cart direction logic
    if input[next_loc[1]][next_loc[0]] == '+'
      intersections += 1
      remainder = intersections % 3
      if remainder == 1
        cart_direction = turn_left(cart[:dir])
      elsif remainder == 2
        cart_direction == cart[:dir]
      else
        cart_direction = turn_right(cart[:dir])
      end
    elsif input[next_loc[1]][next_loc[0]] == 'u' || input[next_loc[1]][next_loc[0]] == 'd'
      if cart_direction == direction[">"] && input[next_loc[1]][next_loc[0]] == 'u'
        cart_direction = turn_left(cart[:dir])
      elsif cart_direction == direction["^"] && input[next_loc[1]][next_loc[0]] == 'u'
        cart_direction = turn_right(cart[:dir])
      elsif cart_direction == direction["<"] && input[next_loc[1]][next_loc[0]] == 'u'
        cart_direction = turn_left(cart[:dir])
      elsif cart_direction == direction["v"] && input[next_loc[1]][next_loc[0]] == 'u'
        cart_direction = turn_right(cart[:dir])
      elsif cart_direction == direction[">"] && input[next_loc[1]][next_loc[0]] == 'd'
        cart_direction = turn_right(cart[:dir])
      elsif cart_direction == direction["^"] && input[next_loc[1]][next_loc[0]] == 'd'
        cart_direction = turn_left(cart[:dir])
      elsif cart_direction == direction["<"] && input[next_loc[1]][next_loc[0]] == 'd'
        cart_direction = turn_right(cart[:dir])
      elsif cart_direction == direction["v"] && input[next_loc[1]][next_loc[0]] == 'd'
        cart_direction = turn_left(cart[:dir])
      end
    else
      cart_direction = cart[:dir]
    end

    carts.each_with_index do |cart_check, j|
      if next_loc == cart_check[:loc] && active_carts.index(cart[:cart_num]) && active_carts.index(cart_check[:cart_num])
        active_carts.delete(cart[:cart_num])
        active_carts.delete(cart_check[:cart_num])
        puts "Collision at #{cart_check[:loc]} between cart #{cart[:cart_num]} and cart #{cart_check[:cart_num]}"
        break
      end
    end

    # end cart direction logic

    carts[i] = {cart_num: cart[:cart_num], loc: next_loc,
                dir: cart_direction, intersections: intersections,
                }
  end
  
  if active_carts.length == 1
    carts.each do |final_check|
      puts "Final location at #{final_check[:loc]}" if final_check[:cart_num] == active_carts[0]
    end
  end
  {carts: carts, active_carts: active_carts}
end

def make_grid(paths)
  lines = paths.split("\n")
  lines.map do |line|
    line.chars
  end
end

def print_map(cart_info, input)
  input_map = Marshal.load( Marshal.dump(input) )

  cart_info[:carts].each do |cart|
    input_map[cart[:loc][1]][cart[:loc][0]] = 'X'.red if cart_info[:active_carts].index(cart[:cart_num])
  end
  input_map.each do |line|
    puts line.join
  end
  nil
end

def remove_carts(input)
  input = input.gsub('^', '|')
  input = input.gsub('>', '-')
  input = input.gsub('v', '|')
  input = input.gsub('<', '-')
end

input = remove_carts(input)
input = make_grid(input)

iterations = 0

until cart_info[:active_carts].length <= 1
  iterations += 1
  cart_info = move_forward(cart_info, input)
  # print_map(cart_info, input)
end
