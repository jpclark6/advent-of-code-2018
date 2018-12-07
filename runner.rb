starting = Time.now

(1..5).each do |day|
  require "./solutions/day_#{day}"
  puts
end

ending = Time.now

puts "Total time: #{ending - starting} seconds"
