require "./lib/artifact"

class A5 < Artifact
  def name
    "a"
  end

  def parent
    A4
  end
end

