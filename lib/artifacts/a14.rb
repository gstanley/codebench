require "./lib/artifact"

class A14 < Artifact
  class << self
    def parent
      A13
    end

    def line
      2
    end

    def code
      "2"
    end
  end
end

