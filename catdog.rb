#!/usr/bin/env ruby

# the animals run with equal speed (6 feet per unit of time)
#
# the only way one of them will win the race is if the other overshoots the mark by a larger
# distance before turning around. (Cat has a better chance of winning since she can only
# overshoot by 1 foot on integer (odd) feet distances and dog by either 1 or 2)

Distance = ARGV[0].to_f
if Distance <= 0 or ARGV.count == 0
  puts "\nUsage: ruby catdog.rb DISTANCE\nWhere DISTANCE is positive\n\n"
  exit 1
end

class Animal
  attr_reader :name
  def initialize name, leap
    @name = name
    @leap = leap
  end

  def full_distance(d)
    # how many full leaps this animal needs to cover (and possibly overshoot) the distance?
    full_leaps = (d/@leap).ceil
    # full distance in feet there and back
    2.0 * full_leaps * @leap
  end

  def Animal.race(a,b,distance)
    # by the time the winner crosses the finish line, the looser still has to go another delta.abs
    delta = a.full_distance(distance) - b.full_distance(distance)
    winner =
      if delta == 0
        nil
      elsif delta > 0
        b
      else
        a
      end
    [winner, delta.abs]
  end

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

