
module Appointme
  # Instance of appointme schedule
  # here you can put your appointments
  # and select with show method
  #   schedule = Appointme::Schedule.new
  #   schedule << Appointme::Appointment.new(:when => "at num", :description => "launch barbecue!")
  #   schedule << Appointme::Appointment.new(:when => "today at 1", :description => "work!")
  #   schedule << Appointme::Appointment.new(:when => "today at 1:30", :description => "get out to meeting!")
  #   puts schedule.show("today at 1")
  #   when?: Monday(17) at 13:00 - work!
  #   when?: Monday(17) at 13:30 - get out to meeting!#
  class Schedule < Array
    # show appointments between some time 
    ## show 'today' # show all appointments for today
    ## show 'sunday at 3:00am' # show between 3 and 3:59  
    def show(what)
      show_appointments = Appointme.get_range_of_time_to_show(what)
      select do |appointment|
        show_appointments.include? appointment.when 
        end.sort_by do |appointment|
          appointment.when
          end
    rescue
      puts "errrr: #{$!}", $@
    end
    # forget incomplete appointments
    def forget
      delete_if{|a| a.incomplete?}
    end
    def appointments
      self
    end
  end
end
