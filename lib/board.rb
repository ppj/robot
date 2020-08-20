# frozen_string_literal: true

require "finer_struct"
require_relative "./robot.rb"

class Board
  class Cell < FinerStruct::Mutable(:x, :y, :robot)
    def empty?
      robot.nil?
    end
  end

  attr_reader :max_x, :max_y, :cells

  def initialize()
    @max_x = 5
    @max_y = 5
    @cells = allocate_cells
  end

  def cell_available?(x, y)
    cell_at_location(x, y)&.empty? || false
  end

  def cell_at_location(x, y)
    cells[x][y] if x_in_board?(x) && y_in_board?(y)
  end

  def fill_location(x:, y:, name:, facing:)
    return unless RobotPlacementChecker.valid?(facing: facing, board: self, x: x, y: y)

    cell_at_location(x, y)&.robot = find_or_create_new_robot(name, facing)
  end

  def robot_details(name)
    if (cell = cell_with_robot(name))
      { x: cell.x, y: cell.y, facing: cell.robot.facing }
    end
  end

  def robot(name)
    cell_with_robot(name)&.robot
  end

  private

  def allocate_cells
    cells = []

    (max_x + 1).times do |x|
      cell_row = []
      (max_y + 1).times do |y|
        cell_row << Cell.new(x: x, y: y)
      end
      cells << cell_row
    end

    cells
  end

  def x_in_board?(x)
    x >= 0 && x <= max_x
  end

  def y_in_board?(y)
    y >= 0 && y <= max_y
  end

  def find_or_create_new_robot(name, facing)
    teleported_robot(name, facing) ||
      Robot.new(name: name, facing: facing)
  end

  def teleported_robot(name, facing)
    if cell_with_robot(name)
      robot = cell_with_robot(name).robot
      cell_with_robot(name).robot = nil
      robot.tap { |robot| robot.facing = facing }
    end
  end

  def cell_with_robot(name)
    cells_with_robots[name]
  end

  def cells_with_robots
    cells.flatten.map do |cell|
      [cell.robot.name, cell] unless cell.empty?
    end.compact.to_h
  end
end
