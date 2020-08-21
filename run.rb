#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "./lib/parser.rb"
require_relative "./lib/commander.rb"

def commander
  @commander ||= Commander.new
end

puts <<-Help
Command line interface to manipulate robots on a board:

Enter a command in the following format:

NAME: ACTION X,Y,F
  NAME   - name of the robot,
  ACTION - one of PLACE, MOVE, LEFT, RIGHT, or REPORT

    Note: only PLACE requires X,Y,F
      X - X co-ordinate of the cell where the robot is to be placed
      Y - Y co-ordinate of the cell where the robot is to be placed
      F - one of NORTH, SOUTH, EAST, WEST

or type EXIT to quit

Help

loop do
  input = gets.chomp
  break if input&.downcase == "exit"

  parsed_input = Parser.parse(input)
  next unless parsed_input

  action, params = parsed_input
  if action == :report
    puts commander.send(action, params)
  else
    commander.send(action, params)
  end
end
