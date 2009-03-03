$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "#{File.dirname(__FILE__)}/../config/requirements.rb"

%w(appointment schedule).each do |file|
  require "#{File.dirname(__FILE__)}/appointme/#{file}.rb"
end

DIR_SNAPSHOTS = 'appointme_snapshots' 

# simple natural language schedule
module Appointme
=begin 
  $madeleine = Madeleine::SnapshotMadeleine.new(DIR_SNAPSHOTS) { Schedule.new }
  $appointme = $madeleine.system
=end
  $appointme ||= Schedule.new

  def self.understand phrase
    $time, $instructions = get_time_and_rest_from phrase
    if $debug
      puts "#{$appointme.inspect}"
      puts "undertanding #{phrase} \n #{$time.inspect} - #{$instructions}"
    end

    case $instructions

    when "show": $appointme.show $time
    when "forget": $appointme.forget #and $madeleine.take_snapshot
    else
      $appointme << Appointment.new(:when => $time,
                                    :description => $instructions)
     # $madeleine.take_snapshot
      self.last_appointment
    end
  end

  # returns the last appointment 
  def self.last_appointment
    $appointme.last
  rescue
    nil
  end

  # get time and other part from prhase, example:
  ## Appointme.get_time_and_rest_from("I'm happy today")     
  ## [Sun Oct 26 19:30:00 -0200 2008, "im happy"]
  def self.get_time_and_rest_from phrase
    time = Chronic.parse phrase
    rest_of_phrase = Chronic.instance_variable_get("@non_tagged_tokens")
    rest_of_phrase = rest_of_phrase.collect{|t|t.word}.join(" ").gsub(/ oclock/,'')
    return [time, rest_of_phrase]
  rescue
    puts "error while parsing phrase '#{phrase}' \n --tracing: #{$!} \n -- #{$@}" if $debug
    [nil, phrase]
  end

  # get range of time
  # when I put "today"
  # its start on 00:00 hour and finish today 23:59
  def self.get_range_of_time_to_show time
    time = Chronic.parse( time, :context => :past) if time.kind_of? String
    sec, min, hour  = time.to_a[0,3]

    hour = 23 if hour == 0
    min = 59 if min == 0
    sec = 59 if sec == 0

    time..Time.mktime(time.year, time.month, time.day, hour, min, sec)
  end     
end
