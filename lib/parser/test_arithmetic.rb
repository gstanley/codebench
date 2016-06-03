dir = File.dirname(__FILE__)
require "#{dir}/test_helper"

Treetop.load "#{dir}/arithmetic"

class ArithmeticGrammarTest < Test::Unit::TestCase
  def setup
    @parser = ArithmeticParser.new
  end

  test "parse numbers" do
    assert @parser.parse("0")
  end
end

