require "./lib/artifact"

class A16 < Artifact
  def name
    "text artifact"
  end

  def parent
    A4
  end

  def lang
    "text"
  end

  def code
    "text line"
  end
end

