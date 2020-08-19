# frozen_string_literal: true

class RobotPlacementChecker
  def self.valid?(facing:, board:, x:, y:)
    new(facing, board, x, y).valid?
  end

  def initialize(facing, board, x, y)
    @facing = facing
    @board = board
    @x = x
    @y = y
  end

  def valid?
    location_available? &&
      facing_direction_valid?
  end

  private

  attr_reader :facing, :board, :x, :y

  def location_available?
    board.cell_available?(x, y)
  end

  def facing_direction_valid?
    Robot.valid_facing_direction?(facing)
  end
end
