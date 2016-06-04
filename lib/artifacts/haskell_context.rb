class HaskellContext < Artifact
  class << self
    def name
      "haskell"
    end
  
    def parent
      A17
    end
  
    def code
      "pwd"
    end

    def structure
      { "main" => { "name" => "prog.hs" } }
    end

    def executor
      "runghc <%= WORK %>/prog.hs"
    end

    def main_body
      <<EOC
(require '[clojure.pprint])
(let [result
  <%= @generated_code %>
]
(clojure.pprint/cl-format true "---~%res: ~s" result))
EOC
    end
  end
end

