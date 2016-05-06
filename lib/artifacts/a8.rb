require "./lib/artifact"

class A8 < Artifact
  class << self
    def name
      "test.txt"
    end
  
    def type
      "file"
    end
  
    def parent
      A4
    end
  end
end

