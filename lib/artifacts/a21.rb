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
      "(message \"hello\")"
    end
  end
end

