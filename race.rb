#!/usr/bin/env ruby

require_relative 'lib/catdog'

Distance = ARGV[0].to_f
if Distance <= 0 or ARGV.count == 0
  puts "\nUsage: ruby catdog.rb DISTANCE\nWhere DISTANCE is positive\n\n"
  exit 1
end

cat = Animal.new "Cat", 2.0
dog = Animal.new "Dog", 3.0
winner, delta = Animal.race(cat,dog,Distance)
if winner
  # round the delta to make output appear integer
  puts "#{winner.name} wins by #{delta.round} feet"
else
  puts 'Draw'
end
