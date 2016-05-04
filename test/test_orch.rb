require "test/unit"
require "./lib/orch"

class TestOrch < Test::Unit::TestCase
# move appropriate code from Art to Orch
# load artifact(s)?
# determine other artifacts
#   use lang/exec context to determine support artifacts
# generate using the artifacts
#   generate source with dependency support artifacts
#   generate source with alternative support artifacts
#   generate source with sensor support artifacts
# save source to work
# compile source using compiler command artifact
# execute script/executable using execution command artifact
  test "generate text" do
    orch = Orch.new( A16 )
    assert_equal "text line", orch.gen
  end

  test "execute text" do
    orch = Orch.new( A16 )
    assert_equal "text line", orch.exec
  end
end

