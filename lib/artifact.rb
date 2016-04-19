require "erb"

class Artifact
  class << self
    def generate
      b = binding
      ERB.new(code).result(b)
    end

    def execute
      b = binding
      out, err, result = capture do
        eval(generate, b)
      end
      {"out" => out, "err" => err, "res" => result}
    end

    def capture
      orig_stdout = $stdout.dup
      orig_stderr = $stderr.dup
      captured_stdout = StringIO.new
      captured_stderr = StringIO.new
      $stdout = captured_stdout
      $stderr = captured_stderr
      result = yield
      captured_stdout.rewind
      captured_stderr.rewind
      return captured_stdout.string, captured_stderr.string, result
    ensure
      $stdout = orig_stdout
      $stderr = orig_stderr
    end

    def code
      ""
    end

    def list
      []
    end

    def doc
      "doc"
    end

    def ldoc
      "long doc"
    end
  end
end

