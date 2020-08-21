# frozen_string_literal: true

class Parser
  def self.parse(input)
    new(input).parse
  end

  def initialize(input)
    @input = input
  end

  def parse
    @name, action_details = input.split(":").map(&:strip)
    return unless action_details

    action_details = action_details.split.map(&:strip)
    action = action_details.shift

    case action.downcase
    when "place"
      return if action_details.empty?

      [:place_robot, placement_params(action_details)] if placement_params(action_details)
    when "move"
      [:move_robot, name]
    when "left"
      [:turn_robot, { name: name, side: :left }]
    when "right"
      [:turn_robot, { name: name, side: :right }]
    when "report"
      [:report, name]
    else
      nil
    end
  end

  private

  attr_reader :input, :name

  def placement_params(placement)
    x, y, facing = placement.join.split(",").map(&:strip)
    return if invalid?(x) || invalid?(y) || facing.nil?
    { name: name, x: x.to_i, y: y.to_i, facing: facing }
  end

  def invalid?(x_or_y)
    x_or_y != x_or_y.to_i.to_s
  end
end
