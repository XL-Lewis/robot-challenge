# Testing
# - [x] Robot is unable to fall off table edge
# - [x] Robot is unable to be placed "off table"
# - [x] Move commands are correctly interpreted for each direction
# - [x] Rotation commands are correctly interpreted for each direction

require "robot"
require "spec_helper"

# Simple validation helper method
def positionIsValid(x,y)
  return x <= 4 && x >= 0 && y <= 4  && y >= 0
end

RSpec.describe Robot do
  describe "cannot move off table" do
    it "north" do
      r = Robot.new(4,4,:north)
      r.move
      expect(positionIsValid(r.xCoord,r.yCoord)).to be_truthy
    end

    it "east" do
      r = Robot.new(4,4,:east)
      r.move
      expect(positionIsValid(r.xCoord,r.yCoord)).to be_truthy
    end

    it "south" do
      r = Robot.new(0,0,:south)
      r.move
      expect(positionIsValid(r.xCoord,r.yCoord)).to be_truthy
    end

    it "west" do
      r = Robot.new(0,0,:west)
      r.move
      expect(positionIsValid(r.xCoord,r.yCoord)).to be_truthy
    end
  end

  describe "move command correctly increments position" do
    it "north" do
      r = Robot.new(2,2,:north)
      r.move
      expect(r.yCoord).to eq(3)
    end
    it "east" do
      r = Robot.new(2,2,:east)
      r.move
      expect(r.xCoord).to eq(3)
    end
    it "south" do
      r = Robot.new(2,2,:south)
      r.move
      expect(r.yCoord).to eq(1)
    end
    it "west" do
      r = Robot.new(2,2,:west)
      r.move
      expect(r.xCoord).to eq(1)
    end
  end

  describe "turn command correctly changes direction" do
    it "left" do
      r = Robot.new(2,2,:north)
      r.turnLeft
      expect(r.direction).to eq(:west)
      r.turnLeft
      expect(r.direction).to eq(:south)
      r.turnLeft
      expect(r.direction).to eq(:east)
      r.turnLeft
      expect(r.direction).to eq(:north)
    end
    it "right" do
      r = Robot.new(2,2,:north)
      r.turnRight
      expect(r.direction).to eq(:east)
      r.turnRight
      expect(r.direction).to eq(:south)
      r.turnRight
      expect(r.direction).to eq(:west)
      r.turnRight
      expect(r.direction).to eq(:north)
    end
  end

  describe "throws an error when" do
    it "initialized with an invalid position" do
      expect {Robot.new(10,10)}.to raise_error(StandardError)
    end
  end
end
