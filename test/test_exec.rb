require "test/unit"
require_relative "../lib/exec"

class TestExec < Test::Unit::TestCase
  test "result is 'res'" do
    result = {
      "res" => "hello"
    }
    assert_equal "hello", result["res"]
  end
end
