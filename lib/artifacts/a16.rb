require "./lib/artifact"

class A16 < Artifact
  class << self
    def name
      "text artifact"
    end
  
    def parent
      A4
    end
  
    def context
      {"name" => "text"}
    end
  
    def code
      "text line"
    end
  end
end

