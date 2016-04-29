require "./lib/artifact"

class A4 < Artifact
  class << self
    def name
      "root"
    end

    def line
      1
    end
  end
end

