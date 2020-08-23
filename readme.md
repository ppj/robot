# Toy robot manipulator
This program lets you control toy-robots on a 6x6 board.

The lower left corner of the board has the co-ordinates X = 0 & Y = 0.


## Installation
Clone this repository with
```bash
git clone git@github.com:ppj/robot.git
```

Ensure you have Ruby version 2.6.6 or above installed.

Install necessary gems with
```bash
bundle install
```

## Tests

Run all tests with
```bash
rspec
```

## Execution

Refer to the [command reference section](#command-reference) for a list of allowed commands.

### Inline command mode (CLI)

Run the following command
```bash
./run.rb
```

Enable quick feedback to see whether your commands worked (👌) or not (👎) by providing a `-v` or `--verbose` switch to the above command like so
```bash
./run.rb --verbose
```

### Read commands from a file
Run the following command
```bash
./run.rb /path/to/the/command/file
```

Notes:
1. `-v` or `--verbose` switch is ignored when running from a file
2. Falls back on the CLI mode if the file is not found.

## Command reference

List of valid commands the program can interpret & action:
- `NAME: PLACE X,Y,F`
  - places a new or existing robot in any empty location on the board, given ...
  - given the `NAME` of the robot,
  - the X & Y coordinates of the location to place it in,
  - the direction `F` in which the robot faces (one of NORTH, EAST, SOUTH, WEST)
- `MOVE`
  - attempts to moves the robot one cell towards the direction it is facing in
- `RIGHT`
  - turns the robot 90° in the clockwise direction within its current location
- `LEFT`
  - turns the robot 90° in the counter-clockwise direction within its current location
- `REPORT`
  - reports the current location and facing direction of the robot

## Design

Class design notes can be found [here](https://github.com/ppj/robot/blob/master/design_notes.md).
