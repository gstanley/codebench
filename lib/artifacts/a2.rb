require "./lib/artifact"

class A2 < Artifact
  class << self
    def name
      "art a2"
    end

    def code
      "puts \"on console\""
    end
  end
end

