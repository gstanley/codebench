require "./lib/artifact"

class A1 < Artifact
  class << self
    def name
      "gen 23"
    end

    def code
      "<%= 23 %>"
    end

    def parent
      A4
    end
  end
end

