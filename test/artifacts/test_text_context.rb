require "test/unit"
require "./test/test_helper"

class TestTextContext < Test::Unit::TestCase
#  test "get code" do
#    assert_equal "\"Hello...\"", @context.code
#  end

  test "get name" do
    assert_equal "text", TextContext.name
  end

#  test "generate code" do
#    assert_equal "\"Hello...\"", @context.generate
#  end

#  test "generate code with <%= 23 %>" do
#    assert_equal "23", @context.generate
#  end

#  test "execute code" do
#    assert_equal 23, @context.execute["res"]
#  end
end

