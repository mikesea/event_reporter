require './command'
require './event_data_parser'
require './queue'

class Search 

  def self.is_data?
    if Queue.queue
    end
  end

  def self.for(parameters)
  	attribute = parameters[0]
  	criteria = parameters[1..-1].join(" ")
    puts "Performing a search for #{parameters.join(" ")}"
    Queue.new

    @search_results = []
    EventDataParser.attendees.select do |attendee|
    	if attendee.respond_to?(attribute.to_sym) && attendee.send(attribute.to_sym).downcase == criteria.downcase
    		@search_results << attendee
    	end
    end

    if @search_results.count <= 0
    	"I could not find any records matching your query. Make sure you've loaded data!"
    else Queue.new 
      Queue.queue = @search_results
    end

    "I found #{Queue.queue.count} records matching your query."
  end

  def self.valid_params?(parameters)
    parameters.count > 1 
  end
end