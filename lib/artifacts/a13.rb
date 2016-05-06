require "./lib/artifact"

class A13 < Artifact
  class << self
    def name
      "test3.txt"
    end
  
    def type
      "file"
    end
  
    def parent
      A4
    end
  end
end

