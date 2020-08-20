# frozen_string_literal: true

require_relative "./board.rb"
require_relative "./robot_placement_checker.rb"

class Commander
  def initialize
    @board = Board.new
  end

  def place_robot(name:, x:, y:, facing:)
    board.fill_location(x: x, y: y, name: name, facing: facing)
  end

  def move_robot(name)
    robot_details = board.robot_details(name)
    return if robot_details.nil?

    x, y = new_location(robot_details)
    board.fill_location(x: x, y: y, name: name, facing: robot_details[:facing])
  end

  private

  attr_reader :board

  def new_location(robot_details)
    x, y, facing = robot_details[:x], robot_details[:y], robot_details[:facing]

    case facing
    when "NORTH"
      y = y + 1
    when "EAST"
      x = x + 1
    when "SOUTH"
      y = y - 1
    when "WEST"
      x = x - 1
    end

    [x, y]
  end
end
