require "erb"
require "find"
require "./lib/orch"
case RUBY_PLATFORM
when /cygwin|mswin|mingw|bccwin|wince|emx/
  require "stringio"
when /darwin/
else
end
require "byebug"

class Artifact
  class << self
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

    def context
      {"name" => "ruby"}
    end
  end
end

class Art
  class << self
    @current = "/"

    def get_by_name( name )
      $artifacts.find {|art| art.name == name}
    end

    def get_root
      ($artifacts.find {|art| art.parent.nil?})
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
  class_name = case file
  when /a([0-9]*).rb/
    "A#$1"
  when /([a-z]*)_context.rb/
    "#{$1.capitalize}Context"
  end
  $artifacts << eval(class_name)
end
$artifacts.sort! do |x, y|
  if x.to_s =~ /A[\d]*/ && y.to_s =~ /A[\d]*/
    x.to_s[1..-1].to_i <=> y.to_s[1..-1].to_i
  else
    x.to_s <=> y.to_s
  end
end

