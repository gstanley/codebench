require "./lib/artifact"

class A11 < Artifact
  class << self
    def parent
      A10
    end

    def line
      1
    end

    def code
      <<EOC
abc
def
EOC
    end
  end
end

