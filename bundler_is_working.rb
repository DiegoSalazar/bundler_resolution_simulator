#!/usr/bin/env ruby -wKU

# Bundler loves resolving dependencies. 
# This script simulates the awesome things bundler does, with snarky a twist.

$dot = '.'
$an_hour = 60*60
$bundler_says = {
  1 => "Fetching source index from https://gems.contribsys.com/",
  4 => "Fetching gem metadata from http://rubygems.org/",
  3 => "Fetching version metadata from http://rubygems.org/",
  5 => "Fetching dependency metadata from http://rubygems.org/",
  $an_hour => "Resolving dependencies."
}
$bundler_yells = [
  "Holy Shit",
  "Just frikin",
  "Dude!",
  "WTF",
  "Sit down and",
  "This will take a while so",
  "fuck man",
  "You bitch!",
  "I REPEAT",
  "Shut up and",
  "Holy cheeses crust",
  "Shut you hole and",
  "Get a coffee and",
  "Keep your tighties on and",
  "GAHDAMNIT",
  "Srsly",
  "DO YOU WANT TO DIE",
  "SUCK IT and",
  "I'll crash us.",
  "",
  ""
]

def yell_at_user
  prefix = rand < 0.5 ? $bundler_yells.sample : ''
  hold = rand < 0.5 ? 'hold on' : 'HOLD ON'

  print "\b\b" # backspace so we get rid of the ^C the terminal adds when a control key is pressed
  print "#{prefix} #{hold}! I'm still resolving."

  begin
    sleep $an_hour # muahaha
  rescue SystemExit, Interrupt
    yell_at_user
  end
end

begin
  Thread.new do
    sleep 1 # simulate bundler starting up

    $bundler_says.each_with_index do |(dots_count, phrase), i|
      print phrase

      if i < $bundler_says.size-1 # Fetching
        if rand > 0.3 # %70 chance we go into dots printing loop
          dots_count.times do
            sleep 1
            print $dot
          end
        end

      else # Resolving....
        print phrase

        dots_count.times do
          sleep 1
          print $dot
        end
      end

      puts
    end
  end

  sleep $an_hour
rescue SystemExit, Interrupt
  yell_at_user
end
