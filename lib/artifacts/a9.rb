require "./lib/artifact"

class A9 < Artifact
  def parent
    A8
  end

  def code
    "abc"
  end
end

