require './command'

class Help

  ALL_COMMANDS = {"load" => "loads a new file", 
                    "help" => "shows a list of available commands",
                    "queue" => "a set of data",
                    "queue count" => "total items in the queue", 
                    "queue clear" => "empties the queue",
                    "queue print" => "prints to the queue", 
                    "queue print by" => "prints the specified attribute",
                    "queue save to" => "exports queue to a CSV", 
                    "find" => "load the queue with matching records"}

  def self.for(parameters)
  	if parameters == []
  		puts "Type 'help' before any of these terms for more detail:"
  		"#{ALL_COMMANDS.keys.join(", ")}"
  	else
  		"#{parameters.join(" ")}: " + ALL_COMMANDS[parameters.join(" ")]
  	end
  end

  def self.valid_command?(command)
  	ALL_COMMANDS.keys.include?(command)
  end

  def self.valid_params?(parameters)
    parameters.empty? || valid_command?(parameters.join(" "))
  end
end