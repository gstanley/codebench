require "./artifact"

class A1 < Artifact
  class << self
    def name
      "gen 23"
    end

    def code
      "<%= 23 %>"
    end
  end
end

