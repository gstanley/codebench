require "./lib/artifact"

class A6 < Artifact
  class << self
    def name
      "b"
    end
  
    def parent
      A5
    end
  
    def line
      1
    end
  end
end

