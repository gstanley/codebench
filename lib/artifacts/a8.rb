require "./lib/artifact"

class A8 < Artifact
  def name
    "test.txt"
  end

  def type
    "file"
  end

  def parent
    A4
  end
end

