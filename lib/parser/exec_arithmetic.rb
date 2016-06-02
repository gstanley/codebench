require "treetop"

Treetop.load "./arithmetic.treetop"
parser = ArithmeticParser.new

puts parser.parse("0") ? "success" : "failed"

