require "test/unit"
require "./lib/artifacts/text_context"

class TestTextContext < Test::Unit::TestCase
  setup do
    @context = TextContext.new
  end

#  test "get code" do
#    assert_equal "\"Hello...\"", @context.code
#  end

  test "get name" do
    assert_equal "text", @context.name
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

