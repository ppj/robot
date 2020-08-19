# frozen_string_literal: true

require_relative "../lib/commander.rb"
require_relative "../lib/board.rb"
require_relative "../lib/robot.rb"
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
      allow(board).to receive(:cell_available?).with(x, y).and_return(cell_available?)
    end

    context "when the provided location is available" do
      let(:cell_available?) { false }

      it { is_expected.to eq("Location (#{x}, #{y}) not available") }
    end

    context "when the cell at the  provided location is available" do
      let(:cell_available?) { true }

      context "but the provided facing direction for robot is invalid" do
        before do
          allow(Robot).to receive(:valid_facing_direction?).and_return(false)
        end

        it { is_expected.to eq("Robot cannot face the direction '#{facing}'") }
      end

      context "and the provided facing direction for the robot is valid" do
        before do
          allow(Robot).to receive(:valid_facing_direction?).and_return(true)
        end

        it "adds the robot to the board successfully" do
          expect(board).to receive(:occupy_cell).with(x: x, y: y, name: name, facing: facing)

          place_robot
        end
      end
    end
  end
end
