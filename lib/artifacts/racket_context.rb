class RacketContext < Artifact
  class << self
    def name
      "racket"
    end
  
    def parent
      A17
    end
  
    def code
      ""
    end

    def structure
      { "main" => { "name" => "prog.rkt" } }
    end

    def executor
      "racket -f <%= WORK %>/prog.rkt"
    end

    def main_body
      <<EOC
(let ((result
  <%= @generated_code %>
))
(printf "---~%res: ~s" result))
EOC
    end
  end
end

