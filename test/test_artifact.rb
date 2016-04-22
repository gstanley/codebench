require "test/unit"
require "./lib/artifact"

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

  test "location" do
    assert_equal "*history*", A0.file
    assert_equal 1, A0.line
    assert_equal 1, A0.slot
    assert_equal "", A1.file
    assert_equal 0, A1.line
  end

  test "get artifact by name" do
    assert_equal A0, Art.get_by_name( "hello" )
  end

  test "get artifact by path" do
    assert_equal A4, Art.get_by_path( "/" )
  end
end

