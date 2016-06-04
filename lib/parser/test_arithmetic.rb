dir = File.dirname(__FILE__)
require "#{dir}/test_helper"

Treetop.load "#{dir}/arithmetic"

class ArithmeticGrammarTest < Test::Unit::TestCase
  include ParserTestHelper

  def setup
    @parser = ArithmeticParser.new
  end

  test "parse numbers" do
    assert_equal 0, parse("0").eval
    assert_equal 123, parse("123").eval
  end

  test "parse variables" do
    assert_equal 2, parse("x").eval({'x' => 2})
  end

  test "parse multiplicative expressions" do
    assert_equal 20, parse("x * 10").eval({'x' => 2})
    assert_equal 4 * 3 * 2, parse("4 * 3 * 2 * 1").eval({})
  end

  test "parse additive expressions" do
    assert_equal 5 + 2 * 10 - 5, parse("5 + x * 10 - y").eval({'x' => 2, 'y' => 5})
  end
end

