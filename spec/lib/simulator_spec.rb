require 'simulator'

describe Simulator do
  before do
    @sim = Simulator.new
  end
  it 'starts in a known state' do
    @sim.should_not be_done
    @sim.time.should == 0
  end
  it 'schedules initial events'
  it 'performs a step'
  it 'knows when it is time to stop'
end
