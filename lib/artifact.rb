require "erb"

class Artifact
  class << self
    def generate
      b = binding
      ERB.new(code).result(b)
    end

    def execute
      eval generate
    end
  end
end

