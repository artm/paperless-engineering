#!/usr/bin/env ruby

require_relative 'lib/catdog'

cat = Animal.new "Cat", 2.0
dog = Animal.new "Dog", 3.0
rnd = Random.new

wins = Hash.new 0
draws = 0
races = 0


trap 'EXIT' do
  puts "\r  \nIn #{races} races"
  wins.each do |animal, cnt|
    puts "#{animal.name} won #{cnt} times (#{100*cnt/races}%)"
  end
  puts "There was #{draws} draws (#{100*draws/races}%)"
end

while true
  distance = rnd.rand(20...1000)
  winner, delta = Animal.race(cat, dog, distance)

  trap 'INT', 'IGNORE'
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
  trap('INT') { exit }
  sleep 0.01 # give user a chance to break
end
