class ClojureContext < Artifact
  class << self
    def name
      "clojure"
    end
  
    def parent
      A17
    end
  
    def code
      "pwd"
    end

    def structure
      { "main" => { "name" => "prog.clj" } }
    end

    def executor
      "clojure <%= WORK %>/prog.clj"
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

