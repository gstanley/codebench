require "./test/test_helper"

class TextContext < Artifact
  class << self
    def name
      "ruby"
    end
  
    def parent
      A17
    end
  
    def code
      "1 + 1"
    end

    def tasks
      ["generate", "execute"]
    end

    def generate_code
      <<EOC
b = binding
ERB.new(@artifact.code).result(b)
EOC
    end

    def execute_code
      <<EOC
@gen_results
EOC
    end
  end
end

