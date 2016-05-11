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
    orch = Orch.new( Art.get_by_path( "/text artifact" ) )
    orch.generate
    assert_equal "text line", orch.gen_results
    orch = Orch.new( Art.get_by_path( "/hello" ) )
    orch.generate
    assert_equal "\"Hello...\"", orch.gen_results
  end

  test "execute text" do
    orch = Orch.new( Art.get_by_path( "/text artifact" ) )
    orch.execute_tasks
    assert_equal "text line", orch.exec_results["res"]
  end

  test "execute tasks" do
    orch = Orch.new( Art.get_by_path( "/text artifact" ) )
    orch.execute_tasks
    assert_equal "text line", orch.exec_results["res"]
  end

  test "execute ruby" do
    orch = Orch.new( Art.get_by_path( "/gen 23" ) )
    orch.execute_tasks
    assert_equal 23, orch.exec_results["res"]
  end

  test "execute ruby with stdout" do
    orch = Orch.new( Art.get_by_path( "/art a2" ) )
    orch.execute_tasks
    assert_equal "on console\n", orch.exec_results["out"]
  end
end

