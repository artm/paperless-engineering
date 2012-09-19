require 'catdog'

describe Animal do
  before do
    @cat = Animal.new 'Cat', 2
    @dog = Animal.new 'Dog', 3
  end

  it 'knows its name' do
    @cat.name.should == 'Cat'
  end

  it 'overshoots when appropriate' do
    @cat.full_distance(1).should == 4
    @cat.full_distance(2).should == 4
    @cat.full_distance(3).should == 8
    @cat.full_distance(4).should == 8
    @cat.full_distance(5).should == 12
    @cat.full_distance(6).should == 12
    @cat.full_distance(7).should == 16
    @cat.full_distance(8).should == 16

    @dog.full_distance(1).should == 6
    @dog.full_distance(2).should == 6
    @dog.full_distance(3).should == 6
    @dog.full_distance(4).should == 12
    @dog.full_distance(5).should == 12
    @dog.full_distance(6).should == 12
    @dog.full_distance(7).should == 18
    @dog.full_distance(8).should == 18
  end

  it 'can compete among each other' do
    Animal.race(@cat,@dog,1).should == [@cat, 2]
    Animal.race(@cat,@dog,2).should == [@cat, 2]
    Animal.race(@cat,@dog,3).should == [@dog, 2]
    Animal.race(@cat,@dog,4).should == [@cat, 4]
    Animal.race(@cat,@dog,5).should == [ nil, 0]
    Animal.race(@cat,@dog,6).should == [ nil, 0]
    Animal.race(@cat,@dog,7).should == [@cat, 2]
    Animal.race(@cat,@dog,8).should == [@cat, 2]
  end
end

describe TacticalAnimal do
  it 'never overshoots' do
    cat = TacticalAnimal.new 'Cat', 2
    (1..10).each {|x| cat.full_distance(x).should == 2*x}
  end
end
