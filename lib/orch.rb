require "./lib/artifact"

class Orch
  attr_reader :tasks, :gen_results, :exec_results

  def initialize( art )
    @artifact = art
    @context = case art.lang
    when "text"
      TextContext
    when "ruby"
      RubyContext
    end
    @tasks = @context.tasks
  end

  def generate
    @gen_results = @artifact.code
  end

  def execute
    @exec_results = @gen_results
  end
end

