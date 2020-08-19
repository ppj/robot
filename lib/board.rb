# frozen_string_literal: true

require "finer_struct"
require_relative "./robot.rb"

class Board
  class Cell < FinerStruct::Mutable(:board, :x, :y, :robot)
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
    x <= max_x &&
      y <= max_y &&
      cell_at_location(x, y).empty?
  end

  def cell_at_location(x, y)
    cells[x][y] if x <= max_x && y <= max_y
  end

  private

  def allocate_cells
    cells = []

    (max_x + 1).times do |x|
      cell_row = []
      (max_y + 1).times do |y|
        cell_row << Cell.new(board: self, x: x, y: y)
      end
      cells << cell_row
    end

    cells
  end
end
