require "./lib/artifact"

class A6 < Artifact
  def name
    "b"
  end

  def parent
    A5
  end

  def line
    1
  end
end

