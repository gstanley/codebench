require "./lib/artifact"

class A10 < Artifact
  def name
    "test2.txt"
  end

  def type
    "file"
  end

  def parent
    A4
  end
end

