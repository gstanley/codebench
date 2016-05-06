require "test/unit"
require "./lib/artifact"
require "byebug"

class TestArtifact < Test::Unit::TestCase
  setup do
    Art.set_current( "/a/b" )
  end

  test "get code" do
    assert_equal "\"Hello...\"", Art.get_by_path( "/" ).code
  end

  test "get name" do
    assert_equal "hello", Art.get_by_path( "/" ).name
  end

  test "generate code" do
    assert_equal "\"Hello...\"", Art.get_by_path( "/" ).generate
  end

  test "generate code with <%= 23 %>" do
    assert_equal "23", Art.get_by_path( "/gen 23" ).generate
  end

  test "execute code" do
    assert_equal 23, Art.get_by_path( "/gen 23" ).execute["res"]
  end

  test "execute with stdout" do
    assert_equal "on console\n", Art.get_by_path( "/art a2" ).execute["out"]
  end

  test "list" do
    assert_equal [], Art.get_by_path( "/" ).list
    assert_equal ["a", "b", "c"], Art.get_by_path( "/art a3" ).list
  end

  test "short doc" do
    assert_equal "Hello World", Art.get_by_path( "/" ).doc
    assert_equal "doc", Art.get_by_path( "/gen 23" ).doc
  end

  test "long doc" do
    assert_equal "artifact that outputs Hello...", Art.get_by_path( "/" ).ldoc
    assert_equal "long doc", Art.get_by_path( "/gen 23" ).ldoc
  end

  test "location" do
    assert_equal "*history*", Art.get_by_path( "/" ).file
    assert_equal 1, Art.get_by_path( "/" ).line
    assert_equal 1, Art.get_by_path( "/" ).slot
    assert_equal "", Art.get_by_path( "/gen 23" ).file
    assert_equal 0, Art.get_by_path( "/gen 23" ).line
  end

  test "get artifact by name" do
    assert_equal Art.get_by_path( "/" ), Art.get_by_name( "hello" )
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
    assert_equal A4, Art.get_by_path( "/" ).class
    assert_equal A7, Art.get_by_path( "/a/b/c" ).class
  end

  test "get artifact by relative path" do
    Art.set_current( "/a/b" )
    assert_equal A7, Art.get_by_path( "c" ).class
  end

  test "get artifact by path with index" do
    assert_equal A0, Art.get_by_path( "/#1" ).class
    assert_equal A7, Art.get_by_path( "/a#1/c" ).class
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
    assert_equal ["1", "2"], Art.get_file_contents( Art.get_by_path( "/test13.txt" ) )
  end

  test "execute a text artifact" do
byebug
    assert_equal "text line\n", Art.get_by_path( "/text artifact" ).execute
  end

  test "get text execution context" do
    assert_equal Art.get_by_path( Art.get_by_path( "/" ) ), Art.get_by_path( "/exec contexts/text" ).class
  end
end

