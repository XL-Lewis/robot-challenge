require_relative "robot"
class Parser
  attr_reader :robot
  @robot = nil

  # Handle command input and dictate moves to robot
  def parseCommand(cmd)
    args = cmd.strip.downcase.split(' ')
    return invalidCommand(cmd) if args.length > 2

    begin
      if args[0] == "place"
        placeData = args[1].split(',')
        x = placeData[0].to_i
        y = placeData[1].to_i
        @robot = Robot.new(x,y,placeData[2].to_sym)
      elsif !@robot.nil?
        case args[0]
          when "move"
            @robot.move
          when "left"
            @robot.turn(:left)
          when "right"
            @robot.turn(:right)
          when "report"
            return @robot.report
          else
            return invalidCommand(cmd)
        end
      elsif args[0] == "help"
        return help
      else
        return invalidCommand(cmd.strip)
      end
    rescue Exception => e
      return "Error: #{e}"
    end
    return
  end

  def invalidCommand(cmd)
    return "'#{cmd}' is an invalid command! Options are PLACE, MOVE, LEFT, RIGHT, REPORT, HELP"
  end

  def help
    result = "PLACE x,y,f  - Create a new robot with coordinates x,y (int) and direction f (north/east/south/west)\n"
    result += "MOVE - Move forward 1 square\n"
    result += "LEFT - Turn left\n"
    result += "RIGHT - Turn right\n"
    result += "REPORT - Print current coords and direction"
    return result
  end
end
