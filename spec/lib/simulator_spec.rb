require 'catdog'
require 'simulator'

describe Simulator do
  before do
    @cat = Animal.new 'Cat', 2, leap_time: 2
    @dog = Animal.new 'Dog', 3, leap_time: 3
    @sim = Simulator.new @dog, @cat, 1
  end
  it 'starts in a known state' do
    @sim.should_not be_done
    @sim.time.should == 0
  end
  it 'schedules initial events' do
    @sim.events[0][:time].should == 2
    @sim.events[0][:racer].should == @cat
    @sim.events[1][:time].should == 3
    @sim.events[1][:racer].should == @dog
  end
  it 'performs a step' do
    @sim.step
    @sim.time.should == 2
    @sim.events[0][:time].should == 3
    @sim.events[0][:racer].should == @dog
    @sim.events[1][:time].should == 4
    @sim.events[1][:racer].should == @cat
  end
  it 'knows when it is time to stop' do
    @sim.step
    @sim.should_not be_done
    @sim.step
    @sim.should_not be_done
    @sim.step
    @sim.should be_done
  end
  it 'knows the winner' do
    @sim.run
    @sim.winner.should == @cat
    winners = [nil,@cat,@cat,@dog,@cat,nil,nil,@cat,@cat]
    (1..8).each do |d|
      @sim = Simulator.new @dog, @cat, d
      @sim.run
      @sim.winner.should == winners[d]
    end

  end
end
