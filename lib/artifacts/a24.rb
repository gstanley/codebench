require "./lib/artifact"

class A24 < Artifact
  class << self
    def name
      "haskell evaluation"
    end
  
    def parent
      A4
    end
  
    def context
      {"name" => "haskell"}
    end

    def code
      "(+ 1 2 3)"
    end
  end
end

