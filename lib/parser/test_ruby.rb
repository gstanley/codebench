dir = File.dirname(__FILE__)
require "#{dir}/test_helper"

Treetop.load "#{dir}/ruby"

class RubyGrammarTest < Test::Unit::TestCase
  include ParserTestHelper

  def setup
    @parser = RubyParser.new
  end

  test "parse expression" do
    result = parse("1.class").tree
    assert_equal "1", result.method_call.primary_value.text
    assert_equal "class", result.method_call.operation2.text
  end

  test "parse expression with comment and float" do
    result = parse("0.0.class # => Float: floating-point numbers have class Float").tree
    assert_equal "0.0", result.method_call.primary_value.text
    assert_equal "class", result.method_call.operation2.text
    assert_equal " => Float: floating-point numbers have class Float", result.method_call.comment.text
  end
end
