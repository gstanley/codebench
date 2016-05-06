require "./lib/artifact"

class A3 < Artifact
  def name
    "art a3"
  end

  def list
    ["a", "b", "c"]
  end

  def parent
    A4
  end
end

