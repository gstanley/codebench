require "yaml"
require "./lib/artifact"

class Orch
  attr_reader :generated_code, :exec_results
  WORK = "~/work"

  def initialize( art )
    @artifact = art
    context = eval("#{art.context["name"].capitalize}Context")
    @context_params = @artifact.context
    @context_params["executor"] ||= context.executor
    @context_params["main-body"] ||= context.main_body
    @context_params["structure"] ||= context.structure
    @context_params["name"] ||= context.name
#    @context_params["generate_code"] ||= context.generate_code
#    @context_params["execute_code"] ||= context.execute_code
#    @context_params["tasks"] ||= context.tasks
  end

  def execute
    @exec_results = if @context_params["executor"] == "<ruby process>"
      b = binding
      out, err, result = capture do
        eval(@generated_code, b)
      end
      {"res" => result, "out" => out, "err" => err}
    elsif @context_params["executor"] == "<text process>"
      {"res" => @generated_code}
    else
      out = err = ""
      Open4.popen4(@generated_command) do |pid, stdin, stdout, stderr|
        out = stdout.read
        err = stderr.read
      end
      { "out" => out, "err" => err }
    end
  end

  def execute_tasks
    #@context_params["tasks"].each do |task|
    #  send(task.to_sym)
    #end
    generate_source
    generate_executor
    formatter_outputter
    save_sources
    execute
    parse_results
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

  # source expression
  #   (+ 1 2 3)
  def generate_source
    b = binding
    @generated_code = ERB.new(@artifact.code).result(b)
  end
  # exec command
  #   clisp #{WORK}/prog.lisp
  def generate_executor
    b = binding
    @generated_command = ERB.new(@context_params["executor"]).result(b)
  end
  # exec sensors
  # formatter/outputter
  #   (format t "---~%res: ~s" result)
  def formatter_outputter
    b = binding
    if @context_params["structure"]
      name_entry = @context_params["structure"]["main"]["name"]
    else
      name_entry = nil
    end
    @files = [{
      "name" => name_entry,
      "body" => ERB.new(@context_params["main-body"]).result(b)
      }]
  end
  def save_sources
    @files.each do |file|
      if file["name"]
        File.open(File.expand_path(File.join(WORK, file["name"])), "w") do |f|
          f.write(file["body"])
        end
      end
    end
  end
  # parse output
  def parse_results
    if !["ruby", "shell", "text"].include?(@context_params["name"])
      @exec_results = YAML.load(@exec_results["out"])
    end
  end
  # exec source
end

