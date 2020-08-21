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
Command line interface to manipulate robots on a board:

Enter EXIT to quit, or

Enter a command in the following format:

NAME: ACTION X,Y,F
  NAME   - name of the robot,
  ACTION - one of PLACE, MOVE, LEFT, RIGHT, or REPORT

    Note: only PLACE requires X,Y,F
      X - X co-ordinate of the cell where the robot is to be placed
      Y - Y co-ordinate of the cell where the robot is to be placed
      F - one of NORTH, SOUTH, EAST, WEST

Help

loop do
  input = gets.chomp
  exit if input&.downcase == "exit"

  process_input(input)
end
