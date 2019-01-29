h = {}
File.readlines('./puzzle_txt/day_7.txt').each do |l|
  i, j = l[36], l[5]
  h[i] ||= []
  h[j] ||= []
  h[i] << j
end

f = ''
until h.empty?
  e = h.select {|k,v| v.empty?}.keys.sort[0]
  h.delete(e)
  h.each {|k,v| v.delete(e)}
  f += e
end
puts f
