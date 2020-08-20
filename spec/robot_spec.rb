# frozen_string_literal: true

require_relative "../lib/robot.rb"

RSpec.describe Robot do
  describe ".new" do
    context "with a valid facing direction", :aggregate_failures do
      it "creates successfully" do
        %w(NORTH EAST SOUTH WEST).each do |facing|
          expect { described_class.new(name: "whatever", facing: facing) }.not_to raise_error
        end
      end
    end

    context "with an invalid facing direction" do
      it "raises an error" do
        expect { described_class.new(name: "whatever", facing: "i_cant_face_you") }.to raise_error(Robot::InvalidFacingDirectionError)
      end
    end
  end

  describe "#turn" do
    describe ":right" do
      it "rotates the robot clockwise by 90°", :aggregate_failures do
        robot = described_class.new(name: "me", facing: "NORTH")

        expect { robot.turn(:right) }.to change { robot.facing }.from("NORTH").to("EAST")
        expect { robot.turn(:right) }.to change { robot.facing }.from("EAST").to("SOUTH")
        expect { robot.turn(:right) }.to change { robot.facing }.from("SOUTH").to("WEST")
        expect { robot.turn(:right) }.to change { robot.facing }.from("WEST").to("NORTH")
      end
    end

    describe ":left" do
      it "rotates the robot anticlockwise by 90°", :aggregate_failures do
        robot = described_class.new(name: "me", facing: "NORTH")

        expect { robot.turn(:left) }.to change { robot.facing }.from("NORTH").to("WEST")
        expect { robot.turn(:left) }.to change { robot.facing }.from("WEST").to("SOUTH")
        expect { robot.turn(:left) }.to change { robot.facing }.from("SOUTH").to("EAST")
        expect { robot.turn(:left) }.to change { robot.facing }.from("EAST").to("NORTH")
      end
    end
  end
end
