require "./lib/artifact"

class A12 < Artifact
  def parent
    A10
  end

  def line
    4
  end

  def code
    "after break"
  end
end

