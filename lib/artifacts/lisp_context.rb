class LispContext < Artifact
  class << self
    def name
      "lisp"
    end
  
    def parent
      A17
    end
  
    def code
      "pwd"
    end

    def structure
      { "main" => { "name" => "prog.lisp" } }
    end

    def executor
      "clisp <%= WORK %>/prog.lisp"
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

