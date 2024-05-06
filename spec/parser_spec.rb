# Testing
# - [ ] Invalid/malformed commands are ignored or print errors
# - [ ] Status message correctly outputs current coords and direction
# - [ ] Commands before a robot is initialized are ignored

require "parser"
require 'spec_helper'

# This could be significantly better
# Ideally some simple fuzzing on the inputs, and probably a better framework to handle the CLI

RSpec.describe Parser do
  describe "Invalid commands don't crash the CLI" do
    parser.parseCommand("Broke bad command")
    parser.parseCommand("PLACE 1,2,EAST")
    parser.
  end
  describe "correctly outputs the current position with 'status' commands" do

  end

end
