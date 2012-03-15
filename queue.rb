require './command'
require './search'
#require './event_reporter_cli'
require './attendee'

class Queue<Attendee

  attr_accessor :last_name, :first_name, :email_address, :zipcode, :state, :street

  def initialize
    @@queue = []
  end

  @@queue =[]

  def self.queue=(value)
     @@queue = value
  end

  def self.queue
    @@queue
  end

  def self.clear
    @@queue.clear
    "Yo dawg I just cleared your queue."
  end

  def self.count
    "The queue currently contains #{@@queue.count} record(s)."
  end

  def self.max_length(param)
    attribute_array = @@queue.collect { |record| record.send(param.to_sym) }
    attribute_array = attribute_array.sort_by{ |criteria| criteria.length}
    length = attribute_array.last.length + 1
  end

  def self.save_to(filename)
    output = CSV.open(filename, "w") do |output|
      output << ["first_name", "last_name", "email_address", "homephone", "street", "city", "state", "zipcode"]
      @@queue.each do |record|
        output << [record.first_name, record.last_name, record.email_address, record.phone_number, record.street, record.city, record.state, record.zipcode]
      end
    end
    "I just saved your file."
  end

  def self.sort_by(param)
    if param == ""
      param = "first_name"
    end
    @@queue = @@queue.sort_by { |record| record.send(param.to_sym) }
  end

  def self.print(queue)
    puts "LAST NAME \t FIRST NAME \t EMAIL \t ZIPCODE \t CITY \t STATE \t ADDRESS \t PHONE NUMBER"
    queue.each do |record|
        puts  "#{record.last_name.ljust(max_length("last_name"))}"     + "\t" +
              "#{record.first_name.ljust(max_length("first_name"))}"    + "\t" +
              "#{record.email_address.ljust(max_length("email_address"))}" + "\t" +
              "#{record.zipcode.ljust(max_length("zipcode"))}"       + "\t" +
              "#{record.city.ljust(max_length("city"))}"          + "\t" +
              "#{record.state.ljust(max_length("state"))}"         + "\t" +
              "#{record.street.ljust(max_length("street"))}"        + "\t" +
              "#{record.phone_number.ljust(max_length("phone_number"))}" 
    end 
    "I just printed #{@@queue.count} records.\n"
  end

  def max_length(params)
    max_atts = @@queue.sort_by { |record| record.send(param.to_sym).max.length }
  end

  def self.call(params)
    "Running Queue sub-function #{params[0]}"    
    command = params[0]
    criteria = ""
    if params.length > 1
      criteria = params[2..-1].join(" ")
    end
    case command
      when 'clear'      then clear
      when 'count'      then count 
      when 'print'      then print(sort_by(criteria))
      when 'save'       then save_to(criteria)
    end
  end

  def self.valid_params?(parameters)
     if !%w(count clear print save).include?(parameters[0])
       false
     elsif parameters[0] == "print" 
       parameters.count == 1 || (parameters[1] == "by" && parameters.count == 3 )
     elsif parameters[0] == "save"
       parameters[1] == "to" && parameters.count == 3
     else
       true
     end
  end  
end