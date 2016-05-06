require "./lib/artifact"

class A17 < Artifact
  class << self
    def name
      "exec contexts"
    end
  
    def parent
      A4
    end
  end
end

