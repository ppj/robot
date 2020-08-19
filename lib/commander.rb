# frozen_string_literal: true

require_relative "./board.rb"

class Commander
  def initialize
    @board = Board.new
  end

  def place_robot(name:, x:, y:, facing:)
    unless location_available?(x, y)
      return "Location (#{x}, #{y}) not available"
    end

    unless facing_direction_valid?(facing)
      return "Robot cannot face the direction '#{facing}'"
    end

    board.occupy_cell(x: x, y: y, name: name, facing: facing)
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
