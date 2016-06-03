dir = File.dirname(__FILE__)
require "#{dir}/test_helper"

Treetop.load "#{dir}/arithmetic"

class ArithmeticGrammarTest < Test::Unit::TestCase
  def setup
    @parser = ArithmeticParser.new
  end

  test "parse numbers" do
    assert_equal 0, @parser.parse("0").eval
    assert_equal 123, @parser.parse("123").eval
  end
end

