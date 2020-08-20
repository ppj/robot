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
end
