class Robot
  @@DIRECTIONS = [:north, :east, :south, :west]
  attr_reader :xCoord
  attr_reader :yCoord
  # Create a new robot object
  # Fails if the input coordinates are outside the area
  # Fails if the input direction isn't one of NORTH/EAST/WEST/SOUTH
  def initialize(x, y, f)
    if !(x <= 4 && x >= 0 && y <= 4 && y >= 0)
      raise "Robot initialized with invalid position"
    end
    @xCoord = x
    @yCoord = y
    if @@DIRECTIONS.include?(f)
      @directionIndex = @@DIRECTIONS.index(f)
    else
      raise 'Tried to initialize robot with bogus direction'
    end
  end

  # Return the current direction symbol
  def direction
    return @@DIRECTIONS[@directionIndex]
  end

  # Move robot one step forward in current facing direction
  def move
    case self.direction
      when :north
        @yCoord += 1
      when :south
        @yCoord -= 1
      when :east
        @xCoord += 1
      when :west
        @xCoord -= 1
    end
    @xCoord = @xCoord.clamp(0,4)
    @yCoord = @yCoord.clamp(0,4)
  end

  # Reorient robot according to command
  def turn(val)
    case val
      when :left
        @directionIndex -= 1
      when :right
        @directionIndex += 1
    end
    @directionIndex %= 4
  end

  # Print out the current coords and direction of the robot
  def report
    puts "OUTPUT: #{@xCoord},#{@yCoord},#{self.direction.upcase}"
  end
end
