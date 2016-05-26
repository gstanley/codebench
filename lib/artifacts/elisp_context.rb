class ElispContext < Artifact
  class << self
    def name
      "elisp"
    end
  
    def parent
      A17
    end
  
    def code
      ""
    end

    def structure
      { "main" => { "name" => "prog.lisp" } }
    end

    def executor
      "emacsclient -e \"(load-file \\\"<%= WORK %>/prog.lisp\\\")\" \"*result*\""
    end

    def main_body
      <<EOC
(let ((result
  <%= @generated_code %>
))
(setq *result* result))
EOC
    end
  end
end

