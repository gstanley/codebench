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
    assert_equal "1", result[:expression][:object]
    assert_equal "class", result[:expression][:method_name]
  end
end
