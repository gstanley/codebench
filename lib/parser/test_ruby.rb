dir = File.dirname(__FILE__)
require "#{dir}/test_helper"

Treetop.load "#{dir}/ruby"

class RubyGrammarTest < Test::Unit::TestCase
  include ParserTestHelper

  def setup
    @parser = RubyParser.new
  end

  test "parse expression" do
    assert parse("1.class")
  end
end
