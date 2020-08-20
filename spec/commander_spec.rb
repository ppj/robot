# frozen_string_literal: true

require_relative "../lib/commander.rb"
require_relative "../lib/robot_placement_checker.rb"
require "rspec/its"

RSpec.describe Commander do
  subject(:commander) { described_class.new }

  before do
    allow(Board).to receive(:new).and_return(board)
  end
  let(:board) { double }

  describe "#place_robot" do
    subject(:place_robot) { commander.place_robot(name: name, x: x, y: y, facing: facing) }
    let(:name) { "iRobot" }
    let(:x) { 2 }
    let(:y) { 3 }
    let(:facing) { "upward" }

    it "tells the board to fill the given location" do
      expect(board).to receive(:fill_location).with(x: x, y: y, name: name, facing: facing)

      place_robot
    end
  end

  describe "#move_robot" do
    subject(:move_robot) { commander.move_robot(name) }
    let(:name) { "robot" }

    before do
      allow(board).to receive(:robot_details).with(name).and_return(robot_details)
    end

    context "when the robot with the given name is on the board" do
      let(:robot_details) { { x: x, y: y, facing: facing } }
      let(:x) { 1 }
      let(:y) { 2 }

      context "when facing NORTH" do
        let(:facing) { "NORTH" }

        it "asks the board to move the robot one cell to the NORTH" do
          expect(board).to receive(:fill_location).with(name: name, x: x, y: y + 1, facing: facing)

          move_robot
        end
      end

      context "when facing EAST" do
        let(:facing) { "EAST" }

        it "asks the board to move the robot one cell to the EAST" do
          expect(board).to receive(:fill_location).with(name: name, x: x + 1, y: y, facing: facing)

          move_robot
        end
      end

      context "when facing SOUTH" do
        let(:facing) { "SOUTH" }

        it "asks the board to move the robot one cell to the SOUTH" do
          expect(board).to receive(:fill_location).with(name: name, x: x, y: y - 1, facing: facing)

          move_robot
        end
      end

      context "when facing WEST" do
        let(:facing) { "WEST" }

        it "asks the board to move the robot one cell to the WEST" do
          expect(board).to receive(:fill_location).with(name: name, x: x - 1, y: y, facing: facing)

          move_robot
        end
      end
    end

    context "when there is no robot with the given name on the board" do
      let(:robot_details) { nil }

      it "does nothing" do
        expect(board).not_to receive(:fill_location)

        move_robot
      end
    end
  end

  describe "#report" do
    subject(:report) { commander.report(name) }
    let(:name) { "bobot" }

    it "asks the board for the details of the robot" do
      expect(board).to receive(:robot_details).with(name)

      report
    end
  end

  describe "#turn_robot" do
    subject(:turn_robot) { commander.turn_robot(name, direction) }
    let(:name) { "robocop" }
    let(:direction) { double }

    before do
      allow(board).to receive(:robot).with(name).and_return(robot)
    end

    context "when the board has the robot with the provided name" do
      let(:robot) { double }

      it "asks the robot to turn in the provided direction" do
        expect(robot).to receive(:turn).with(direction)

        turn_robot
      end
    end

    context "when the board does not have a robot with the provided name" do
      let(:robot) { nil }

      it "does not attempt to turn any robot" do
        expect(robot).not_to receive(:turn)

        turn_robot
      end
    end
  end
end
