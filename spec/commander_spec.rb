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

    before do
      allow(RobotPlacementChecker).to receive(:valid?).with(
        facing: facing, board: board, x: x, y: y,
      ).and_return(placement_valid?)
    end

    context "when the robot placement information is valid" do
      let(:placement_valid?) { true }

      it "adds the robot to the board successfully" do
        expect(board).to receive(:fill_location).with(x: x, y: y, name: name, facing: facing)

        place_robot
      end
    end

    context "when the robot placement information is not valid" do
      let(:placement_valid?) { false }

      it "does not attempt to add the robot to the board" do
        expect(board).not_to receive(:fill_location)

        place_robot
      end
    end
  end
end
