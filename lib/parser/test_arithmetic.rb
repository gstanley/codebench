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
  end
end

