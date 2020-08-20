# frozen_string_literal: true

class Robot
  class InvalidFacingDirectionError < StandardError; end

  attr_reader :name, :facing

  def initialize(name:, facing:)
    @name = name
    @facing = validated_facing_direction(facing)
  end

  def self.valid_facing_direction?(facing)
    VALID_FACING_DIRECTIONS.include?(facing)
  end

  def facing=(facing)
    @facing = validated_facing_direction(facing)
  end

  def turn(side)
    case side
    when :right
      turn_right
    when :left
      turn_left
    end
  end

  private

  # order of the directions listed is important for turning
  VALID_FACING_DIRECTIONS = %w(NORTH EAST SOUTH WEST)
  private_constant :VALID_FACING_DIRECTIONS

  def validated_facing_direction(facing)
    raise InvalidFacingDirectionError unless Robot.valid_facing_direction?(facing)
    facing
  end

  def turn_right
    current_index = VALID_FACING_DIRECTIONS.index(facing)
    size = VALID_FACING_DIRECTIONS.size
    next_index = (current_index + 1) % (size)
    @facing = VALID_FACING_DIRECTIONS[next_index]
  end

  def turn_left
    current_index = VALID_FACING_DIRECTIONS.index(facing)
    prev_index = current_index - 1
    @facing = VALID_FACING_DIRECTIONS[prev_index]
  end
end
