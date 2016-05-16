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

    def structure
      nil
    end

    def executor
      "<text process>"
    end

    def main_body
      "<%= @generated_code %>"
    end
  end
end

