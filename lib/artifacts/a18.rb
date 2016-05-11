require "./lib/artifact"

class A18 < Artifact
  class << self
    def name
      "system command - ruby"
    end
  
    def parent
      A4
    end
  
    def context
      {"name" => "shell"}
    end
  
    def code
      "ruby -e \"puts 'hello'\""
    end
  end
end

