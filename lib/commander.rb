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

  private

  attr_reader :board
end
