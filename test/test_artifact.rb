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
    assert_equal 23, A1.execute["res"]
  end

  test "execute with stdout" do
    assert_equal "on console\n", A2.execute["out"]
  end

  test "list" do
    assert_equal [], A0.list
    assert_equal ["a", "b", "c"], A3.list
  end

  test "short doc" do
    assert_equal "Hello World", A0.doc
    assert_equal "doc", A1.doc
  end

  test "long doc" do
    assert_equal "artifact that outputs Hello...", A0.ldoc
    assert_equal "long doc", A1.ldoc
  end
end

