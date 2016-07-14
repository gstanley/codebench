# first move this code into .pryrc

$trace = []
Pry::Commands.create_command "trace" do
  description "Trace the state."

  def setup
    @file = File.expand_path(target.eval('__FILE__'))
    @line = target.eval('__LINE__')
  end

  def process
    $trace << {
      file: @file,
      line: @line,
      code: Pry::Code.from_file(@file).take_lines(@line, 1).to_s
    }
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
