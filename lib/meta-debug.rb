# first move this code into .pryrc

$trace = []
Pry::Commands.create_command "trace" do
  description "Trace the state."

  def setup
    @file = File.expand_path(target.eval('__FILE__'))
    @line = target.eval('__LINE__')
  end

  def options(opt)
    opt.on :r, :repcode, "Set replacement code", :argument => true do |r|
      @repcode = r
    end
  end

  def process
    line_trace = {
      file: @file,
      line: @line,
      code: Pry::Code.from_file(@file).take_lines(@line, 1).to_s.chomp
    }
    line_trace[:repcode] = @repcode if @repcode
    $trace << line_trace
  end
end
Pry::Commands.create_command "show-trace" do
  description "Show the trace."

  def process
    output.puts $trace.inspect
  end
end
Pry::Commands.create_command "clear-trace" do
  description "Clear the trace."

  def process
    $trace = []
  end
end
