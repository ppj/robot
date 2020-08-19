# frozen_string_literal: true

require_relative "./board.rb"

class Commander
  def initialize
    @board = Board.new
  end

  def place_robot(name:, x:, y:, facing:)
    return unless RobotPlacementChecker.valid?(facing: facing, board: board, x: x, y: y)

    board.fill_location(x: x, y: y, name: name, facing: facing)
  end

  private

  attr_reader :board

  def location_available?(x, y)
    board.cell_available?(x, y)
  end

  def facing_direction_valid?(facing)
    Robot.valid_facing_direction?(facing)
  end
end
