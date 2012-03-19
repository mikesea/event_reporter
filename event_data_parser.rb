require 'csv'
require './command'
require './search'

class EventDataParser

  CSV_OPTIONS = {:headers => true, :header_converters => :symbol}

  def initialize
    @@attendees = []
    @@data = false
  end

  @@data = false

  def self.data=(value)
     @@queue = value
  end

  def self.data
    @@data
  end

  def self.attendees
    @@attendees
  end

  def self.load(parameters)
    filename = parameters[0]
    if filename.nil?
      filename = "event_attendees.csv"
    end
    file = CSV.open(filename, CSV_OPTIONS)
    load_attendees(file)
  end

  def self.valid_params?(params)
    params.count == 0 || ( params.count == 1 && params[0] =~ /\.csv$/ )
  end

  def self.load_attendees(file)
    file.rewind
    @@attendees = file.collect { |line| Attendee.new(line) }
    @@data = true
    "Your data were loaded.\n"
  end

end
