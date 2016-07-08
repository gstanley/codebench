loop do
  line = gets
  break if /^exit|quit|bye/ =~ line
  puts line
end
