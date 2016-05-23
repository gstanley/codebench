require "./lib/artifact"

class A21 < Artifact
  class << self
    def name
      "elisp evaluation"
    end
  
    def parent
      A4
    end
  
    def context
      {"name" => "elisp"}
    end

    def code
      "(+ 1 2 3)"
    end
  end
end

