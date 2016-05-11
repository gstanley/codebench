require "test/unit"
require "./test/test_helper"
require "byebug"

# paths:
# A0:  /hello
# A1:  /gen 23
# A2:  /art a2
# A3:  /art a3
# A4:  /
# A5:  /a
# A6:  /a/b
# A7:  /a/b/c
# A8:  /test.txt
# A9:  /test.txt#1
# A10: /test2.txt
# A11: /test2.txt#1
# A12: /test2.txt#2
# A13: /test3.txt
# A14: /test3.txt#1
# A15: /test3.txt#2
# A16: /text artifact
# A17: /exec contents
# TextContext: /exec contents/text

class TestArtifact < Test::Unit::TestCase
  setup do
    Art.set_current( "/a/b" )
  end

  test "get code" do
    assert_equal "\"Hello...\"", Art.get_by_path( "/hello" ).code
  end

  test "get name" do
    assert_equal "hello", Art.get_by_path( "/hello" ).name
  end

  test "list" do
    assert_equal [], Art.get_by_path( "/hello" ).list
    assert_equal ["a", "b", "c"], Art.get_by_path( "/art a3" ).list
  end

  test "short doc" do
    assert_equal "Hello World", Art.get_by_path( "/hello" ).doc
    assert_equal "doc", Art.get_by_path( "/gen 23" ).doc
  end

  test "long doc" do
    assert_equal "artifact that outputs Hello...", Art.get_by_path( "/hello" ).ldoc
    assert_equal "long doc", Art.get_by_path( "/gen 23" ).ldoc
  end

  test "location" do
    assert_equal "*history*", Art.get_by_path( "/hello" ).file
    assert_equal 1, Art.get_by_path( "/hello" ).line
    assert_equal 1, Art.get_by_path( "/hello" ).slot
    assert_equal "", Art.get_by_path( "/gen 23" ).file
    assert_equal 0, Art.get_by_path( "/gen 23" ).line
  end

  test "get artifact by name" do
    assert_equal Art.get_by_path( "/hello" ), Art.get_by_name( "hello" )
  end

  test "get root artifact" do
    assert_equal Art.get_by_path( "/" ), Art.get_root
  end

  test "get child artifact by name and parent" do
    assert_equal Art.get_by_path( "/a" ), Art.get_child( Art.get_by_path( "/" ), {type: :name, value: "a"} )
    assert_equal Art.get_by_path( "/a/b/c" ), Art.get_child( Art.get_by_path( "/a/b" ), {type: :name, value: "c"} )
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
    assert_equal ["b"], Art.get_by_path( "/a" ).list_children
    assert_equal ["hello", "gen 23", "art a2", "art a3", "a", "test.txt", "test2.txt", "test3.txt", "text artifact", "exec contexts"], Art.get_by_path( "/" ).list_children
  end

  test "get file artifact" do
    assert_equal Art.get_by_path( "/test.txt" ), Art.get_file( Art.get_by_path( "/" ), "test.txt" )
  end

  test "get file contents" do
    assert_equal ["abc"], Art.get_file_contents( Art.get_by_path( "/test.txt" ) )
    assert_equal ["abc", "def", "", "after break"], Art.get_file_contents( Art.get_by_path( "/test2.txt" ) )
    assert_equal ["1", "2"], Art.get_file_contents( Art.get_by_path( "/test3.txt" ) )
  end

  test "get text execution context" do
    assert_equal TextContext, Art.get_by_path( "/exec contexts/text" )
  end
end

