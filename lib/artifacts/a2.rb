require "./lib/artifact"

class A2 < Artifact
  def name
    "art a2"
  end

  def code
    "puts \"on console\""
  end

  def parent
    A4
  end
end

