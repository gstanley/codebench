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
      "emacs -batch <%= WORK %>/prog.lisp"
    end

    def main_body
      <<EOC
(let ((result
  <%= @generated_code %>
))
(format t "---~%res: ~s" result))
EOC
    end
  end
end

