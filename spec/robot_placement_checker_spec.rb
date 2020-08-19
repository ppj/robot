# frozen_string_literal: true

require_relative "../lib/robot_placement_checker.rb"
require_relative "../lib/board.rb"

RSpec.describe RobotPlacementChecker do
  describe "#valid?" do
    subject(:valid?) do
      described_class.valid?(facing: facing, board: board, x: x, y: y)
    end
    let(:facing) { "upward" }
    let(:board) { double }

    let(:x) { 2 }
    let(:y) { 3 }

    before do
      allow(board).to receive(:cell_available?).with(x, y).and_return(cell_available?)
    end

    context "when the cell at the provided location is not available" do
      let(:cell_available?) { false }

      it { is_expected.to be(false) }
    end

    context "when the cell at the  provided location is available" do
      let(:cell_available?) { true }

      context "but the provided facing direction for robot is invalid" do
        before do
          allow(Robot).to receive(:valid_facing_direction?).and_return(false)
        end

        it { is_expected.to be(false) }
      end

      context "and the provided facing direction for the robot is valid" do
        before do
          allow(Robot).to receive(:valid_facing_direction?).and_return(true)
        end

        it { is_expected.to be(true) }
      end
    end
  end
end
