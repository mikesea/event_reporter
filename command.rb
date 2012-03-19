require './event_data_parser'
require './help'
require './queue'
require './search'
require './attendee'

class Command

  def initialize
    EventDataParser.new
    Queue.new
    Search.new
  end

  ALL_COMMANDS = {"load" => "loads a new file",
                    "help" => "shows a list of available commands",
                    "queue" => "a set of data",
                    "queue count" => "total items in the queue",
                    "queue clear" => "empties the queue",
                    "queue print" => "prints to the queue",
                    "queue print by" => "prints the specified attribute",
                    "queue save to" => "exports queue to a CSV",
                    "find" => "load the queue with matching records"}

  def self.valid?(command)
    ALL_COMMANDS.keys.include?(command)
  end

  def self.execute(com, params)
    if com == "load" && EventDataParser.valid_params?(params)
      EventDataParser.load(params)
    elsif com == "queue" && Queue.valid_params?(params)
      Queue.call(params)
    elsif com == "help" && Help.valid_params?(params)
      Help.for(params)
    elsif com == "find" && Search.valid_params?(params) && EventDataParser.data
      Search.for(params)
    else
      error_message_for(com)
    end
  end

  def self.error_message_for(command)
    if !EventDataParser.data
      "Looks like you need to load some data."
    else
      "Sorry, you specified invalid arguments for #{command}."
    end
  end
end