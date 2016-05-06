require "./lib/artifact"

class A0 < Artifact
  def name
    "hello"
  end

  def code
    "\"Hello...\""
  end

  def doc
    "Hello World"
  end

  def ldoc
    "artifact that outputs Hello..."
  end

  def file
    "*history*"
  end

  def line
    1
  end

  def parent
    A4
  end
end

