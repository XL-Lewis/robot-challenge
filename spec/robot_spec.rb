# TODO
# Testing
# - [x] Robot is unable to fall off table edge
# - [x] Robot is unable to be placed 'off table'
# - [x] Move commands are correctly interpreted for each direction
# - [x] Rotation commands are correctly interpreted for each direction
# - [ ] Invalid/malformed commands are ignored or print errors
# - [ ] Status message correctly outputs current coords and direction
# - [ ] Commands before a robot is initialized are ignored


require "robot"
require 'spec_helper'

def positionIsValid(x,y)
  return x <= 4 && x >= 0 && y <= 4  && y >= 0
end

RSpec.describe Robot do
  describe 'cannot move off table' do
  # -- Validate cannnot 'fall' off table
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
      expect(r.yCoord == 3).to be_truthy
    end
    it "east" do
      r = Robot.new(2,2,:east)
      r.move
      expect(r.xCoord == 3).to be_truthy
    end
    it "south" do
      r = Robot.new(2,2,:south)
      r.move
      expect(r.yCoord == 1).to be_truthy
    end
    it "west" do
      r = Robot.new(2,2,:west)
      r.move
      expect(r.xCoord == 1).to be_truthy
    end
  end

  describe "turn command correctly changes direction" do
    it "left" do
      r = Robot.new(2,2,:north)
      r.turn(:left)
      expect(r.direction == :west).to be_truthy
      r.turn(:left)
      expect(r.direction == :south).to be_truthy
      r.turn(:left)
      expect(r.direction == :east).to be_truthy
      r.turn(:left)
      expect(r.direction == :north).to be_truthy
    end
    it "right" do
      r = Robot.new(2,2,:north)
      r.turn(:right)
      expect(r.direction == :east).to be_truthy
      r.turn(:right)
      expect(r.direction == :south).to be_truthy
      r.turn(:right)
      expect(r.direction == :west).to be_truthy
      r.turn(:right)
      expect(r.direction == :north).to be_truthy
    end
  end

  describe "throws an error when" do
    it "initialized with an invalid position" do
      expect {Robot.new(10,10)}.to raise_error(StandardError)
    end
  end
end
