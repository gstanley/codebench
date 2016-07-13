# first move this code into .pryrc

Pry::Commands.create_command "trace" do
  description "Trace the state."

  def process
    output.puts "Tracing line..."
  end
end
