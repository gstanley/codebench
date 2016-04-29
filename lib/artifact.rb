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

    # index is stored as a line number (can be breaks)
    def index
      line
    end

    def parent
      nil
    end

    def list_children
      $artifacts.select {|art| art.parent == self}.map {|art| art.name}
    end
  end
end

class Art
  class << self
    @current = "/"
    @current_file_path = "/"
    @fs_root = nil

    def get_by_name( name )
      $artifacts.find {|art| art.name == name}
    end

    def get_root
      $artifacts.find {|art| art.parent.nil?}
    end

    def get_by_path( path )
      parsed_path = parse_path( path )
      if parsed_path[0][:type] == :root
        current = get_root
      else
        current = get_by_path( @current )
      end
      parsed_path[1..-1].each do |name|
        current = get_child( current, name )
      end
      current
    end

    def get_child( parent, ident )
      if ident[:type] == :index
        $artifacts.find {|art| art.parent == parent && art.index == ident[:value]}
      else
        $artifacts.find {|art| art.parent == parent && art.name == ident[:value]}
      end
    end

    def parse_path( path )
      if path[0] == "/"
        header = {type: :root}
        path = path[1..-1]
      else
        header = {type: :current}
      end
      result = [header]
      next_elem = {type: :name}
      path.split(/([#\/])/).each do |elem|
        case elem
        when "/"
          next_elem[:type] = :name
        when "#"
          next_elem[:type] = :index
        when ""
          # nothing
        else
          next_elem[:value] = next_elem[:type] == :name ? elem : elem.to_i
          result << next_elem
          next_elem = {}
        end
      end
      result
    end

    def set_current( path )
      @current = path[0] == "/" ? path : "#@current/#{path}"
    end

    def set_current_file_path( path )
      @current_file_path = path[0] == "/" ? path : "#@current/#{path}"
    end

    def get_file( parent, name )
      $artifacts.find {|art| art.parent == parent && art.name == name && art.type == "file"}
    end

    def get_file_contents( parent )
      line_ctr = 1
      $artifacts.select {|art| art.parent == parent}.sort_by {|art| art.line}.inject( [] ) do |memo, art|
        while line_ctr < art.line
          memo << ""
          line_ctr += 1
        end
        art.code.each_line do |line|
          memo << line.strip
          line_ctr += 1
        end
        memo
      end
    end
  end
end

$artifacts = []
Find.find(File.dirname(__FILE__) + "/artifacts") do |file|
  next if FileTest.directory?(file)
  require file
  $artifacts << eval(File.basename(file, ".rb").capitalize)
end
$artifacts.sort! {|x, y| x.to_s[1..-1].to_i <=> y.to_s[1..-1].to_i}
Art.fs_root = A
