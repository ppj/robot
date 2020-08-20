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

  private

  VALID_FACING_DIRECTIONS = %w(NORTH EAST SOUTH WEST)
  private_constant :VALID_FACING_DIRECTIONS

  def validated_facing_direction(facing)
    raise InvalidFacingDirectionError unless Robot.valid_facing_direction?(facing)
    facing
  end
end
