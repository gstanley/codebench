require "test/unit"
require "./lib/artifacts/a0"

class TestArtifact < Test::Unit::TestCase
  test "get code" do
    assert_equal "\"Hello...\"", A0.code
  end

  test "get name" do
    assert_equal "hello", A0.name
  end

  test "generate code" do
    assert_equal "\"Hello...\"", A0.generate
  end
end

