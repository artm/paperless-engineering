#!/usr/bin/env ruby

require_relative 'lib/catdog'
require_relative 'lib/simulator'

Distance = ARGV[0].to_f
if Distance <= 0 or ARGV.count == 0
  puts "\nUsage: ruby catdog.rb DISTANCE\nWhere DISTANCE is positive\n\n"
  exit 1
end

cat = Animal.new "Cat", 2.0, leap_time: 2
dog = Animal.new "Dog", 3.0, leap_time: 3
sim = Simulator.new cat, dog, Distance
sim.run
winner = sim.winner

# let loser finish, measure time and since they run one feet a tick this will be the distance
# by which the winner won
t_win = sim.time
while sim.events.count > 0 do
  sim.step
end
delta = sim.time - t_win

if winner
  # round the delta to make output appear integer
  puts "#{winner.name} wins by #{delta}"
else
  puts 'Draw'
end
