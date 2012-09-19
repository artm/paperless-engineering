#!/usr/bin/env ruby

require_relative 'lib/catdog'

rnd = Random.new

# race participants
cat = Animal.new "Cat", 2.0
dog = Animal.new "Dog", 3.0

# stats
wins = Hash.new 0
draws = 0
races = 0

# print stats on exit
trap 'EXIT' do
  # keeping up appearances: the \r and spaces are to remove ^C from output
  puts "\r  \nIn #{races} races"
  rest = 100 # start with 100%
  wins.each do |animal, cnt|
    percent = (100.0*cnt/races).round
    rest -= percent # take away each animal's integer percents
    puts "#{animal.name} won #{cnt} times (#{percent}%)"
  end
  # use that to display psychologically sound draw percentage
  puts "There was #{draws} draws (#{rest}%)"
end

# keep racing
while true
  distance = rnd.rand(20...1000)

  # we don't want to be interrupted while processing a race
  trap 'INT', 'IGNORE'
  winner, delta = Animal.race cat, dog, distance
  races += 1
  printf "Distance: %3d, ", distance
  if winner
    # round the delta to make output appear integer
    wins[winner] += 1
    puts "#{winner.name} wins by #{delta.round} feet"
  else
    draws += 1
    puts 'Draw'
  end

  # give the user a chance to break
  trap('INT') { exit }
  sleep 0.01
end
