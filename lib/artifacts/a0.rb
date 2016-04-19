class A0 < Artifact
  class << self
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
  end
end

