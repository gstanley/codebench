require "./lib/artifact"

class A19 < Artifact
  class << self
    def name
      "system command - pwd"
    end
  
    def parent
      A4
    end
  
    def context
      {"name" => "shell"}
    end

    def code
      "pwd"
    end
  end
end

