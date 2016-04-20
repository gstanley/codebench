require "./artifact"

class A3 < Artifact
  class << self
    def name
      "art a3"
    end

    def list
      ["a", "b", "c"]
    end
  end
end

