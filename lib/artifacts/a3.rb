require "./lib/artifact"

class A3 < Artifact
  class << self
    def name
      "art a3"
    end

    def list
      ["a", "b", "c"]
    end

    def parent
      A4
    end
  end
end

