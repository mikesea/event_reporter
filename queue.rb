require './command'
require './search'
require './attendee'

class Queue

  HEADER = ["LAST NAME", "FIRST NAME", "EMAIL",
            "ZIPCODE", "CITY", "STATE", "ADDRESS", "PHONE NUMBER"]

  attr_accessor :last_name, :first_name,
                :email_address, :zipcode, :state, :street

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
      output << ["first_name", "last_name", "email_address",
                "homephone", "street", "city", "state", "zipcode"]
      @@queue.each do |r|
        output << [r.first_name, r.last_name, r.email_address,
                  r.phone, r.street, r.city, r.state, r.zipcode]
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
    HEADER.each do | h |
      printf "#{h} \t "
    end
    puts ""

    queue.each do |record|
        puts  "#{record.last_name.ljust(max_length("last_name"))}"          +
              "#{record.first_name.ljust(max_length("first_name"))}"        +
              "#{record.email_address.ljust(max_length("email_address"))}"  +
              "#{record.zipcode.ljust(max_length("zipcode"))}"              +
              "#{record.city.ljust(max_length("city"))}"                    +
              "#{record.state.ljust(max_length("state"))}"                  +
              "#{record.street.ljust(max_length("street"))}"                +
              "#{record.phone.ljust(max_length("phone"))}"
    end
    "I just printed #{@@queue.count} records.\n"
  end

  def max_length(params)
    max_atts = @@queue.sort_by { |r| r.send(param.to_sym).max.length }
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

  def self.valid_params?(params)
     if !%w(count clear print save).include?(params[0])
       false
     elsif params[0] == "print"
       params.count == 1 || (params[1] == "by" && params.count == 3 )
     elsif params[0] == "save"
       params[1] == "to" && params.count == 3
     else
       true
     end
  end
end