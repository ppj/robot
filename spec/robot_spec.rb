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
end
