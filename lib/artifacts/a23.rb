require "./lib/artifact"

class A23 < Artifact
  class << self
    def name
      "clojure evaluation"
    end
  
    def parent
      A4
    end
  
    def context
      {"name" => "clojure"}
    end

    def code
      "(+ 1 2 3)"
    end
  end
end

