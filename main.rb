require_relative "lib/robot"
require_relative "lib/parser"
require "irb"

parser = Parser.new
loop do
  res = parser.parseCommand(gets)
  puts res if !res.nil?
end
