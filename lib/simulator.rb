class Simulator
  attr_reader :time

  def initialize
    @time=0
  end

  def done?
    false
  end
end
