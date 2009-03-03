def wash_dishes_today
  Appointment.new :when =>Time.now, :description => "Wash dishes"
end
def go_to_dentist_tomorrow
  Appointment.new :when => "tomorrow at 8:34", :description => "go to dentist" 
end
def standup_meeting_tomorrow
  Appointment.new :when => "tomorrow at 8:30", :description => "standup meeting" 
end




