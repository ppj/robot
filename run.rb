#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "./lib/parser.rb"
require_relative "./lib/commander.rb"

# Helper functions

def help
  <<-Help
Command line interface to manipulate robots on a 6x6 board:

To read instructions from a file, run this script like this:
"#{$0} /path/to/the/file"

Type
  EXIT to quit, or

  a command in the following format:

  NAME: ACTION X,Y,F
    NAME   - name of the robot (capitalisation matters),
    ACTION - one of PLACE, MOVE, LEFT, RIGHT, REPORT (capitalisation does not matter)

      Note: X,Y,F required only for PLACE
        X - X co-ordinate (0 to 5 accepted) of the cell where the robot is to be placed
        Y - Y co-ordinate (0 to 5 accepted) of the cell where the robot is to be placed
        F - one of NORTH, SOUTH, EAST, WEST (capitalisation does not matter)

Help
end

def commander
  @commander ||= Commander.new
end

def process_input(input, verbose_mode = false)
  parsed_input = Parser.parse(input)
  unless parsed_input
    puts "👎" if verbose_mode
    return
  end

  action, params = parsed_input
  if action == :report
    puts commander.send(action, params).to_s
  else
    if commander.send(action, params)
      puts "👌" if verbose_mode
    else
      puts "👎" if verbose_mode
    end
  end
end

def run_from_stdin(verbose_mode)
  puts help
  loop do
    input = $stdin.gets.chomp
    exit if input.downcase == "exit"

    process_input(input, verbose_mode)
  end
end

# Main script

if ["--verbose", "-v"].include? ARGV[0]&.downcase
  verbose_mode = true
  ARGV.shift
end

begin
  run_from_stdin(verbose_mode) if ARGF.file == $stdin

  ARGF.readlines.each do |line|
    process_input(line)
  end
  exit
rescue Errno::ENOENT
  puts "Could not find file #{ARGF.filename}"

  run_from_stdin(verbose_mode)
end
