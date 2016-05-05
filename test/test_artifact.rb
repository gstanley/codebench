require "test/unit"
require "./lib/artifact"
require "byebug"

class TestArtifact < Test::Unit::TestCase
  setup do
    Art.set_current( "/a/b" )
  end

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

  test "get root artifact" do
    assert_equal A4, Art.get_root
  end

  test "get child artifact by name and parent" do
    assert_equal A5, Art.get_child( A4, {type: :name, value: "a"} )
    assert_equal A7, Art.get_child( A6, {type: :name, value: "c"} )
  end

  test "parse path" do
    assert_equal [{type: :root}], Art.parse_path( "/" )
    assert_equal [{type: :root}, {type: :name, value: "a"}, {type: :name, value: "b"}, {type: :name, value: "c"}], Art.parse_path( "/a/b/c/" )
    assert_equal [{type: :current}, {type: :name, value: "b"}], Art.parse_path( "b" )
  end

  test "get artifact by absolute path" do
    assert_equal A4, Art.get_by_path( "/" )
    assert_equal A7, Art.get_by_path( "/a/b/c" )
  end

  test "get artifact by relative path" do
    Art.set_current( "/a/b" )
    assert_equal A7, Art.get_by_path( "c" )
  end

  test "get artifact by path with index" do
    assert_equal A0, Art.get_by_path( "/#1" )
    assert_equal A7, Art.get_by_path( "/a#1/c" )
  end

  test "list artifact children" do
    assert_equal ["b"], A5.list_children
    assert_equal ["hello", "gen 23", "art a2", "art a3", "a", "test.txt", "test2.txt", "test3.txt", "text artifact", "exec contexts"], A4.list_children
  end

  test "get file artifact" do
    assert_equal A8, Art.get_file( A4, "test.txt" )
  end

  test "get file contents" do
    assert_equal ["abc"], Art.get_file_contents( A8 )
    assert_equal ["abc", "def", "", "after break"], Art.get_file_contents( A10 )
    assert_equal ["1", "2"], Art.get_file_contents( A13 )
  end

  test "execute a text artifact" do
    assert_equal "text line\n", A16.execute
  end

  test "get text execution context" do
byebug
    assert_equal TextContext, Art.get_by_path( "/exec contexts/text" )
  end
end

