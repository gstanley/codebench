require "test/unit"
require "./lib/artifacts/a0"

class TestArtifact < Test::Unit::TestCase
  test "get code" do
    assert_equal "\"Hello...\"", A0.code
  end
end

