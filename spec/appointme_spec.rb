require 'rubygems'
require 'chronic'
require "#{File.dirname(__FILE__)}/../lib/appointme"
describe "Adding an appointment" do 
  describe "like go to dentist today at 4" do 
    before(:each) do 
      @response = Appointme.understand "go to dentist today at 4"
      @last_appointment = Appointme.last_appointment
    end
    it "should to mark this appointment ok" do
      @response.should_not be_nil
      @last_appointment.should_not be_nil
    end
    it "should know that description is 'go to dentist'" do 
      @last_appointment.description.should be == "go to dentist"
    end
    it "should know what time is it appointment" do 
      @last_appointment.pretty_when.match /16:00:00/
    end
  end
  describe "like go to college" do
    before(:all) do 
      @response = Appointme.understand "go to college"
      @last_appointment = Appointme.last_appointment
    end
    
    it "should have an incomplete appointment" do
      @last_appointment.should be_incomplete
    end

    describe "when answered" do 
       it "should be marked ok" do
         @response = Appointme.understand "when? tuesday 5:00" 
       end
    end
    describe "when forgot" do
      it "should destroy from Schedule" do 
        lambda {
          Appointme.understand "forget"
        }.should change { $appointme.length }
      end
    end
  end
end

describe "Showing appointment" do
  describe "like show today" do 
    before(:all) do 
     Appointme.understand "dentist today at 4" 
    end

    before(:each) do
      @response = Appointme.understand "show today"
    end
    it "should to show dentist appointment" do
      @response.should_not be_nil
    end
    it "cant create other appointment" do 
        lambda {
          Appointme.understand "show today"
        }.should_not change { $appointme.appointments.length }
    end
  end
end
describe "Parsing date and hour" do 
   describe "like 'today at 20'" do 
     before(:all) do
       @between = Appointme.get_range_of_time_to_show Time.gm(2008, 12, 10, 20) # like 10/12/2008 at 20
     end

     it "should put first and last hour at 20" do
       @between.first.hour.should be == 20
       @between.last.hour.should be == 20
     end

     describe "last hour" do 
       it "should have 59 minutes" do
         @between.last.min.should be == 59
       end
       it "should have 59 seconds" do
         @between.last.sec.should be == 59
       end
     end

   end
   describe "like 'today'" do 
     before(:all) do
       @between = Appointme.get_range_of_time_to_show Time.gm(2008, 12, 10) # like 10/12/2008 > whole day
     end

     it "should put first hour with 00:00:00" do
       @between.first.hour.should be == 00
       @between.first.min.should be == 00
       @between.first.sec.should be == 00
     end
     it "should put last hour with 23:59:59" do
       @between.last.hour.should be == 23
       @between.last.min.should be == 59
       @between.last.sec.should be == 59
     end
   end
end
   
