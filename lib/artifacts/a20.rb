require "./lib/artifact"

class A20 < Artifact
  class << self
    def name
      "lisp evaluation"
    end
  
    def parent
      A4
    end
  
    def context
      {"name" => "lisp"}
    end

    def code
      "(+ 1 2 3)"
    end
  end
end

