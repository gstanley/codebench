require "./lib/artifact"

class A15 < Artifact
  class << self
    def parent
      A13
    end

    def line
      1
    end

    def code
      "1"
    end
  end
end

