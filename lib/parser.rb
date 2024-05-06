require_relative "robot"
class Parser
  @robot = nil

  # Handle command input and dictate moves to robot
  def parseCommand(cmd)
    args = cmd.strip.downcase.split(' ')

    if args.length > 2
      invalidCommand(cmd)
    end
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
            @robot.report
        end
      end
    rescue Exception => e
      puts "Err: #{e}"
    end
  end

  def invalidCommand(cmd)
    puts "'#{cmd}' is an invalid command! Options are:\n"
    puts "PLACE x,y,f  - Create a new robot with coordinates x,y (int) and direction f (north/east/south/west)"
    puts "MOVE - Move forward 1 square"
    puts "LEFT - Turn left"
    puts "RIGHT - Turn right"
    puts "REPORT - Print current coords and direction"
  end
end
