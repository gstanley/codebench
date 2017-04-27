require "test/unit"
require_relative "../lib/exec"

class TestExec < Test::Unit::TestCase
  test "failure" do
    flunk "will fail"
  end
end
