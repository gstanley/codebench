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
    orch.generate
    assert_equal "text line", orch.gen_results
  end

  test "execute text" do
    orch = Orch.new( A16 )
    orch.generate
    orch.execute
    assert_equal "text line", orch.exec_results
  end

  test "tasks" do
    orch = Orch.new( A16 )
    assert_equal ["generate", "execute"], orch.tasks
  end
end

