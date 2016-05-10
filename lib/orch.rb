require "./lib/artifact"

class Orch
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
end

