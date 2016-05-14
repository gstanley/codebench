#require "open4"

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
      {}
    end

    def executor
      "<ruby process>"
    end

    def main_body
      "<%= @generated_code %>"
    end
#    def generate_code
#      <<EOC
#b = binding
#ERB.new(@artifact.code).result(b)
#EOC
#    end

#    def execute_code
#      <<EOC
#out = err = ""
#Open4.popen4(@gen_results) do |pid, stdin, stdout, stderr|
#  out = stdout.read
#  err = stderr.read
#end
#{ "out" => out, "err" => err }
#EOC
    end
  end
end

