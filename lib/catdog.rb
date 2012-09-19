# the animals run with equal speed (6 feet per unit of time)
#
# the only way one of them will win the race is if the other overshoots the mark by a larger
# distance before turning around. (Cat has a better chance of winning since she can only
# overshoot by 1 foot on integer (odd) feet distances and dog by either 1 or 2)


class Animal
  attr_reader :name, :leap, :leap_time
  def initialize name, leap, args={}
    @name = name
    @leap = leap
    @leap_time = args[:leap_time] || 0
  end

  def full_distance(d)
    # how many full leaps this animal needs to cover (and possibly overshoot) the distance?
    full_leaps = (d.to_f/@leap).ceil
    # full distance in feet there and back
    2.0 * full_leaps * @leap
  end

  def simulate_leap
    [@leap, @leap_time]
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

# assuming some animals are better trained than others (or are smarter / lazier by nature)
class TacticalAnimal < Animal
  def full_distance(d)
    # tactical animal adjusts the length of the last leap to avoid overshooting
    2.0 * d
  end
end


