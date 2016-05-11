class TextContext < Artifact
  class << self
    def name
      "text"
    end
  
    def parent
      A17
    end
  
    def code
      "text line"
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
{"res" => @gen_results}
EOC
    end
  end
end

