require "find"

Find.find("./test") do |file|
  next if FileTest.directory?(file)
  require file
end

