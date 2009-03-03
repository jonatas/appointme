
module Appointme
  # represents an appointment with time and description
  #  puts Appointme::Appointment.new :when => "next sunday at 7:30", :description => "go to church"
  #  => when?: Sunday(02) at 07:30 - go to church
  #  puts Appointme::Appointment.new :when => Time.mktime(2008,10,10,19,30), :description => "go to church"
  #  => when?: Friday(10) at 19:30 - go to church
  class Appointment
    attr_accessor :description, :when
    
    # new appointment with constructor by appointment's data:
    #   Appointme::Appointment.new :when => Time.mktime(2008,10,10,19,30), :description => "go to church"
    #   Appointme::Appointment.new :when => "today at 7"
    #   Appointme::Appointment.new :description => "go to church"
    #   Appointme::Appointment.new
    def initialize(opts={})
       self.when = opts[:when]
       self.description = opts[:description]
    end
    # sets when an appointment happened 
    # by string or by time object
    # like:
    #    Appointme::Appointment.new :when => "next sunday at 2"
    #    Appointme::Appointment.new :when => Time.now, :description => "wash dishes"
    def when=(time)
      if time.kind_of? String
         @when = Chronic.parse(time)
      else
         @when = time
       end
    end
    #pretty string about when this appointment happened
    #  puts Appointme::Appointment.new(:when => "today at 4", :description => "wash dishes").pretty_when                     
    #  => Monday(17) at 16:00#
    def pretty_when
      if dont_know_when?
        "I don't know"
      else
        @when.strftime("%A(%d) at %H:%M")
      end
    end
    # when time makes no sense
    def dont_know_when?
      @when.nil?
    end
    # when there are imcomplete data
    def incomplete?
      dont_know_when? || @description.nil?
    end
    # prints appointment like humans
    #   puts Appointme::Appointment.new(:when => "today at 4", :description => "wash dishes")
    #   when?: Monday(17) at 16:00 - wash dishes#
    def to_s
      "when?: #{self.pretty_when} - #{@description}"
    end
 end
end
