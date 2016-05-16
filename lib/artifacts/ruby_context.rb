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

    def structure
      nil
    end

    def executor
      "<ruby process>"
    end

    def main_body
      "<%= @generated_code %>"
    end
  end
end

