require "./lib/artifact"

class Orch
  WORK = "~/work"
  attr_reader :tasks, :gen_results, :exec_results

  def initialize( art )
    @artifact = art
    context = eval("#{art.context["name"].capitalize}Context")
    @context_params = @artifact.context
    @context_params["generate_code"] ||= context.generate_code
    @context_params["execute_code"] ||= context.execute_code
    @context_params["tasks"] ||= context.tasks
  end

  def generate
    @gen_results = eval @context_params["generate_code"]
  end

  def execute
    @exec_results = eval @context_params["execute_code"]
  end

  def execute_tasks
    @context_params["tasks"].each do |task|
      send(task.to_sym)
    end
  end

  def capture
    orig_stdout = $stdout.dup
    orig_stderr = $stderr.dup
    captured_stdout = StringIO.new
    captured_stderr = StringIO.new
    $stdout = captured_stdout
    $stderr = captured_stderr
    result = yield
    captured_stdout.rewind
    captured_stderr.rewind
    return captured_stdout.string, captured_stderr.string, result
  ensure
    $stdout = orig_stdout
    $stderr = orig_stderr
  end
end

