class Zipcode
  def self.clean(dirty_zipcode)
    dirty_zipcode.to_s.rjust(5, '0')
  end
end

class PhoneNumber
  def self.clean(dirty_phone_number)
    @phone = dirty_phone_number.scan(/\d/).join.to_s
    @phone = "(#{@phone[0..2]}) #{@phone[3..5]}-#{@phone[6..-1]}"
  end

end

class State
  def self.clean(dirty_state)
    dirty_state.to_s
  end
end

class Street
  def self.clean(dirty_street)
    dirty_street.to_s
  end
end

class City
  def self.clean(dirty_street)
    dirty_street.to_s
  end
end

class Attendee

  attr_accessor :dirty_first_name, :dirty_last_name, :dirty_zipcode,
                :dirty_phone_number, :email_address, :dirty_state,
                :dirty_city, :dirty_street

  def initialize(attributes={})
    self.dirty_first_name       = attributes[:first_name]
    self.dirty_last_name        = attributes[:last_name]
    self.dirty_zipcode          = attributes[:zipcode]
    self.dirty_phone_number     = attributes[:homephone]
    self.email_address          = attributes[:email_address]
    self.dirty_state            = attributes[:state]
    self.dirty_city             = attributes[:city]
    self.dirty_street           = attributes[:street]
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def first_name
    if dirty_first_name
      dirty_first_name.split.collect{ |n| n.capitalize }.join(" ")
    end
  end

  def last_name
    if dirty_last_name
      dirty_last_name.capitalize
    end
  end

  def zipcode
    Zipcode.clean(dirty_zipcode)
  end

  def phone
    PhoneNumber.clean(dirty_phone_number)
  end

  def state
    State.clean(dirty_state)
  end

  def address
    street
  end

  def street
    Street.clean(dirty_street)
  end

  def city
    City.clean(dirty_city)
  end

end

