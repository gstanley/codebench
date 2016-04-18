require "test/unit"
require "find"
require "./lib/artifact"
Find.find("./lib/artifacts") do |file|
  require file unless FileTest.directory?(file)
end

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

  test "generate code with <%= 23 %>" do
    assert_equal "23", A1.generate
  end

  test "execute code" do
    assert_equal 23, A1.execute
  end
end

