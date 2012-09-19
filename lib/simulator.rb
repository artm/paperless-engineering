class Simulator
  attr_reader :time, :events, :winner
  There=1
  Back=-1

  def initialize racer1, racer2, distance
    @distance = distance
    @time=0
    @winner=nil
    @draw = false
    @events = []
    schedule racer1,0,There
    schedule racer2,0,There
    sort_events
  end

  def done?
    @winner || @draw || @events.count == 0
  end

  def schedule racer, d, dir=1
    leap, d_time = racer.simulate_leap
    @events << { time: @time+d_time, racer: racer, d: d+leap*dir, dir: dir }
  end

  def sort_events
    @events = @events.sort_by {|event| event[:time]}
  end

  def step
    @time = @events[0][:time]
    while @events.count>0 && @events[0][:time] == @time do
      event = @events.shift
      dir = event[:dir]
      d = event[:d]
      if d <= 0
        if @winner
          @winner = nil
          @draw = true
        else
          @winner = event[:racer]
        end
      else
        dir = Back if dir == There && d >= @distance
        schedule event[:racer], d, dir
        sort_events
      end
    end
  end

  def run
    while !done?
      step
    end
  end
end
