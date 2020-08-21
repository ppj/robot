# frozen_string_literal: true

require_relative "../lib/parser.rb"

require "rspec/its"

RSpec.describe Parser do
  describe ".parse" do
    subject(:parse) { described_class.parse(input) }

    context "with a valid input" do
      context "place action" do
        let(:input) { "ROBOCOP: PLACE 1, 3,NORTH" }

        it { is_expected.to eq([:place_robot, { name: "ROBOCOP", x: 1, y: 3, facing: "NORTH" }]) }
      end

      context "move action" do
        let(:input) { "ROBOCOP: MOVE" }

        it { is_expected.to eq([:move_robot, "ROBOCOP"]) }
      end

      context "turn left action" do
        let(:input) { "ROBOCOP: LEFT" }

        it { is_expected.to eq([:turn_robot, { name: "ROBOCOP", side: :left }]) }
      end

      context "turn right action" do
        let(:input) { "ROBOCOP: RIGHT" }

        it { is_expected.to eq([:turn_robot, { name: "ROBOCOP", side: :right }]) }
      end

      context "report action" do
        let(:input) { "ROBOCOP: REPORT" }

        it { is_expected.to eq([:report, "ROBOCOP"]) }
      end

      context "with incorrect capitalisation of actions" do
        it "still works", :aggregate_failures do
          [
            ["ROBOCOP: move", [:move_robot, "ROBOCOP"]],
            ["ROBOCOP: left", [:turn_robot, { name: "ROBOCOP", side: :left }]],
            ["ROBOCOP: right", [:turn_robot, { name: "ROBOCOP", side: :right }]],
            ["ROBOCOP: place 1,2,EAST", [:place_robot, { name: "ROBOCOP", x: 1, y: 2, facing: "EAST" }]],
          ].each do |input, expected|
            expect(described_class.parse(input)).to eq(expected)
          end
        end
      end
    end

    context "invalid input" do
      context "name cannot be determined" do
        let(:input) { "I DO NOT HAVE A COLON" }

        it { is_expected.to be(nil) }
      end

      context "name can be determined" do
        context "but action details cannot be determined" do
          let(:input) { "NAME: INVALID_REST_OF_THE_INPUT" }

          it { is_expected.to be(nil) }
        end
      end

      context "placement details not provided" do
        let(:input) { "ROBOCOP: PLACE" }

        it { is_expected.to be(nil) }
      end

      context "placement details cannot be determined" do
        let(:input) { "ROBOCOP: PLACE ME,NO,VALID" }

        it { is_expected.to be(nil) }
      end
    end
  end
end
