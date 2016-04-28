require "./lib/artifact"

class A5 < Artifact
  class << self
    def name
      "a"
    end

    def parent
      A4
    end
  end
end

