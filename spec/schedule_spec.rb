require "#{File.dirname(__FILE__)}/../lib/appointme"
require "#{File.dirname(__FILE__)}/spec_helper"
include Appointme

describe "Schedule" do 
  before(:all) do 
    @schedule = Schedule.new 
  end

  describe "initializing" do 
    it "shouldn't have appointments" do
      @schedule.should have(0).appointments
    end

    it "when add an appointment should be released" do
      @schedule.appointments << wash_dishes_today
      @schedule.appointments.should have(1).appointments
    end
  end

  describe "when search by whole day" do 

    before(:all) do 
      @schedule.appointments << wash_dishes_today
      @schedule.appointments << go_to_dentist_tomorrow
      @schedule.appointments << standup_meeting_tomorrow
      @appointments = @schedule.show("tomorrow at 8")
    end

    it "should give 2 appointments" do 
      @appointments.length.should == 2
    end

    it "should sort by time" do 
      @appointments.should be == @appointments.sort_by{|e|e.when}
    end
  end
end
