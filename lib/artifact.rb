require "erb"

class Artifact
  class << self
    def generate
      b = binding
      ERB.new(code).result(b)
    end
  end
end

