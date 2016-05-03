require "./lib/artifact"

class Orch
  def initialize( art )
    @artifact = art
  end

  def gen
    @artifact.generate
  end

  def exec
    @artifact.execute
  end
end

