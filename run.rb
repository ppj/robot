#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "./lib/parser.rb"
require_relative "./lib/commander.rb"

def commander
  @commander ||= Commander.new
end

def process_input(input)
  parsed_input = Parser.parse(input)
  return unless parsed_input

  action, params = parsed_input
  if action == :report
    puts commander.send(action, params).to_s
  else
    commander.send(action, params)
  end
end

file = ARGV[0]

if file
  if File.exist?(file)
    File.readlines(file).each do |line|
      process_input(line)
    end
  else
    puts "Could not find the file '#{file}'"
  end
  exit
end

puts <<-Help
Command line interface to manipulate robots on a 6x6 board:

To read instructions from a file, run this script like this:
"#{$0} /path/to/the/file"

Enter EXIT to quit, or

Enter a command in the following format:

NAME: ACTION X,Y,F
  NAME   - name of the robot (capitalisation matters),
  ACTION - one of PLACE, MOVE, LEFT, RIGHT, REPORT (capitalisation does not matter)

    Note: X,Y,F required only for PLACE
      X - X co-ordinate (0 to 5 accepted) of the cell where the robot is to be placed
      Y - Y co-ordinate (0 to 5 accepted) of the cell where the robot is to be placed
      F - one of NORTH, SOUTH, EAST, WEST (capitalisation does not matter)

Help

loop do
  input = gets.chomp
  exit if input&.downcase == "exit"

  process_input(input)
end
