require "./lib/artifact"

class Orch
  attr_reader :tasks

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

  def gen
    @artifact.generate
  end

  def exec
    @artifact.execute
  end
end

