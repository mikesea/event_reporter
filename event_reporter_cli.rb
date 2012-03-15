require './command'
require './queue'
require './search'
require './event_data_parser'

class EventReporterCLI
  EXIT_COMMANDS = ["quit", "q", "e", "exit"]

  def self.parse_user_input(input)
    [ input.first.downcase, input[1..-1] ]
  end

  def self.prompt_user
    printf "enter command > "
    gets.strip.split
  end

  def self.data?
    EventDataParser.data
  end

  def self.run
    puts "Welcome to the EventReporter"
    results = ""

    while results
      results = execute_command(prompt_user)      
      puts results if results
    end

    puts "Goodbye!"
  end

  def self.execute_command(inputs)
    if inputs.any?
      command, parameters = parse_user_input(inputs)
      Command.execute(command, parameters) unless quitting?(command)
    else
      "No command entered."
    end
  end

  def self.quitting?(command)
    EXIT_COMMANDS.include?(command)
  end
end

EventReporterCLI.run
Queue.new