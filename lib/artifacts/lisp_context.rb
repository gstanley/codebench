require "open4"

class LispContext < Artifact
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

    def tasks
      ["generate", "execute"]
    end

    def generate_code
      <<EOC
b = binding
[{
  "file" => "prog.lisp",
  "content" => ERB.new(@artifact.code).result(b)
}]
EOC
    end

    def execute_code
      <<EOC
out = err = ""
Open4.popen4("clisp #{WORK}/prog.lisp") do |pid, stdin, stdout, stderr|
  out = stdout.read
  err = stderr.read
end
{ "out" => out, "err" => err }
EOC
    end

    def 
  end
end

