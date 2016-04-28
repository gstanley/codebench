require "./lib/artifact"

class A7 < Artifact
  class << self
    def name
      "c"
    end

    def parent
      A6
    end
  end
end

