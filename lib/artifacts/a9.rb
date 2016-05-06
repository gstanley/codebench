require "./lib/artifact"

class A9 < Artifact
  class << self
    def parent
      A8
    end
  
    def code
      "abc"
    end
  end
end

