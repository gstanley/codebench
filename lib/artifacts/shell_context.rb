class ShellContext < Artifact
  class << self
    def name
      "shell"
    end
  
    def parent
      A17
    end
  
    def code
      "pwd"
    end

    def structure
      nil
    end

    def executor
      main_body
    end

    def main_body
      "<%= @generated_code %>"
    end
  end
end

