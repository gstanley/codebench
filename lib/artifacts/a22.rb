require "./lib/artifact"

class A22 < Artifact
  class << self
    def name
      "racket evaluation"
    end
  
    def parent
      A4
    end
  
    def context
      {"name" => "racket"}
    end

    def code
      "(+ 1 2 3)"
    end
  end
end

