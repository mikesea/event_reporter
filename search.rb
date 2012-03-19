require './command'
require './event_data_parser'
require './queue'

class Search

  def self.is_data?
    if Queue.queue
    end
  end

  def self.for(parameters)
    a = parameters[0]
    c = parameters[1..-1].join(" ")
    puts "Performing a search for #{parameters.join(" ")}"
    Queue.new

    @search_results = []
    EventDataParser.attendees.select do |at|
      if at.respond_to?(a.to_sym) && at.send(a.to_sym).downcase == c.downcase
        @search_results << at
      end
    end

    if @search_results.count <= 0
      "I could not find any records matching your query."
    else Queue.new
      Queue.queue = @search_results
    end
    "I found #{Queue.queue.count} records matching your query."
  end

  def self.valid_params?(parameters)
    parameters.count > 1
  end
end