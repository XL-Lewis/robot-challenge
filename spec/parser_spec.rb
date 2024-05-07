# Testing
# - [X] Invalid/malformed commands are ignored or print errors
# - [X] Status message correctly outputs current coords and direction
# - [X] Commands before a robot is initialized are ignored

require "parser"
require 'spec_helper'

# This could be significantly better
# Ideally some simple fuzzing on the inputs, and probably a better framework to handle the CLI

RSpec.describe Parser do
  it "does not crash on invalid commands" do
    parser = Parser.new
    result = parser.parseCommand("Broke bad command")
    expect(result).to eq("'Broke bad command' is an invalid command! Options are PLACE, MOVE, LEFT, RIGHT, REPORT, HELP")
  end
  it "correctly sets current position with a place command" do
    parser = Parser.new
    parser.parseCommand("PLACE 1,2,EAST")
    expect(parser.robot.direction).to eq(:east)
    expect(parser.robot.xCoord).to eq(1)
    expect(parser.robot.yCoord).to eq(2)
  end
  it "correctly reports position with 'status' command" do
    parser = Parser.new
    parser.parseCommand("PLACE 1,2,EAST")
    status = parser.parseCommand("report")
    expect(status).to eq("OUTPUT: 1,2,EAST")
  end
  it "ignores commands before a robot has been placed" do
    parser = Parser.new
    parser.parseCommand("MOVE")
    parser.parseCommand("MOVE")
    parser.parseCommand("MOVE")
    parser.parseCommand("PLACE 3,3,SOUTH")
    expect(parser.robot.direction).to eq(:south)
    expect(parser.robot.xCoord).to eq(3)
    expect(parser.robot.yCoord).to eq(3)
  end
  it "returns an error when placing a robot off the table" do
    parser = Parser.new
    result = parser.parseCommand("PLACE 3,5,SOUTH")
    expect(result).to eq("Error: Robot initialized with invalid position")
  end
  it "returns an error when placing a robot with an invalid direction" do
    parser = Parser.new
    result = parser.parseCommand("PLACE 3,3,AAA")
    expect(result).to eq("Error: Tried to initialize robot with bogus direction")
  end
end
