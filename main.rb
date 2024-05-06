require_relative "lib/robot"
require_relative "lib/parser"
require "irb"

parser = Parser.new
loop do
  parser.parseCommand(gets)
end
