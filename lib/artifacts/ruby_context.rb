class RubyContext < Artifact
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
b = binding
out, err, result = capture do
  eval(@gen_results, b)
end
{"res" => result, "out" => out, "err" => err}
EOC
    end
  end
end

