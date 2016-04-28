require "erb"
require "find"
case RUBY_PLATFORM
when /cygwin|mswin|mingw|bccwin|wince|emx/
  require "stringio"
when /darwin/
else
end

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

    def file
      ""
    end

    def line
      0
    end

    # slot is stored as a line number (slots can be multiline)
    def slot
      line
    end

    def parent
      nil
    end
  end
end

class Art
  class << self
    def get_by_name( name )
      $artifacts.find {|art| art.name == name}
    end

    def get_root
      $artifacts.find {|art| art.parent.nil?}
    end

    def get_by_path( path )
      get_root
    end
  end
end

$artifacts = []
Find.find(File.dirname(__FILE__) + "/artifacts") do |file|
  next if FileTest.directory?(file)
  require file
  $artifacts << eval(File.basename(file, ".rb").capitalize)
end

