# frozen_string_literal: true

require_relative "../lib/board.rb"
require_relative "../lib/robot_placement_checker.rb"

require "rspec/its"

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe "a new board" do
    its(:max_x) { is_expected.to eq(5) }
    its(:max_y) { is_expected.to eq(5) }

    describe "cells" do
      subject(:cells) { board.cells }

      it "creates rows of cells" do
        expect(cells.size).to eq(board.max_y + 1)
      end

      it "creates cells in each row", :aggregate_failures do
        cells.each do |cell_row|
          expect(cell_row.size).to eq(board.max_x + 1)
        end
      end

      it "creates empty cells" do
        board.cells.each do |cell_row|
          cell_row.each do |cell|
            expect(cell).to be_empty
          end
        end
      end
    end
  end

  describe "#cell_at_location" do
    subject(:cell_at_location) { board.cell_at_location(x, y) }

    context "when the x value is out of bounds" do
      let(:x) { board.max_x + 1 }
      let(:y) { board.max_y - 1 }

      it { is_expected.to be(nil) }
    end

    context "when the y value is out of bounds" do
      let(:x) { board.max_x - 1 }
      let(:y) { board.max_y + 1 }

      it { is_expected.to be(nil) }
    end

    context "when the location is inside the boundary" do
      let(:x) { board.max_x }
      let(:y) { board.max_y }

      it { is_expected.to be_a(Board::Cell) }
    end
  end

  describe "#cell_available?" do
    subject(:cell_available?) { board.cell_available?(x, y) }

    context "when the x value is out of bounds" do
      let(:x) { board.max_x + 1 }
      let(:y) { board.max_y - 1 }

      it { is_expected.to be(false) }
    end

    context "when the y value is out of bounds" do
      let(:x) { board.max_x - 1 }
      let(:y) { board.max_y + 1 }

      it { is_expected.to be(false) }
    end

    context "when the location is inside the boundary" do
      let(:x) { board.max_x }
      let(:y) { board.max_y }

      context "but the cell at the location is not empty" do
        before do
          # TODO: Replace once occupy cell is implemented
          board.cell_at_location(x, y).robot = double
        end

        it { is_expected.to be(false) }
      end
    end
  end

  describe "#fill_location" do
    subject(:fill_location) { board.fill_location(x: x, y: y, name: name, facing: facing) }
    let(:x) { board.max_x }
    let(:y) { board.max_y }
    let(:name) { "iRoboto" }
    let(:facing) { "facing" }

    before do
      allow(RobotPlacementChecker).to receive(:valid?).with(
        facing: facing, board: board, x: x, y: y,
      ).and_return(placement_valid?)
    end

    let(:cell) { board.cell_at_location(x, y) }

    context "when the robot placement information is not valid" do
      let(:placement_valid?) { false }

      it "does not attempt to put the robot in the cell" do
        expect(cell).not_to receive(:robot)

        fill_location
      end
    end

    context "when the robot placement information is valid" do
      let(:placement_valid?) { true }

      context "when a robot with a provided name is already on the board" do
        before do
          old_cell.robot = robot
        end
        let(:old_cell) { board.cell_at_location(old_x, old_y) }
        let(:old_x) { 0 }
        let(:old_y) { 0 }
        let(:robot) { double(name: name, "facing=": nil) }

        it "removes the robot from the old location" do
          fill_location

          expect(old_cell).to be_empty
        end

        it "teleports it to the new location" do
          fill_location

          expect(cell.robot).to eq(robot)
        end

        it "assigns the specified direction to the teleported robot" do
          fill_location

          expect(robot).to have_received(:facing=).with(facing)
        end
      end

      context "when a robot with a provided name is not on the board" do
        before do
          allow(Robot).to receive(:new).and_return(robot)
        end
        let(:robot) { double }

        it "creates a new robot" do
          expect(Robot).to receive(:new).with(name: name, facing: facing)

          fill_location
        end

        it "adds the robot to the board successfully" do
          expect(cell).to receive(:robot=).with(robot)

          fill_location
        end
      end
    end
  end
end
