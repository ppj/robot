# frozen_string_literal: true

require_relative "../lib/board.rb"
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
end
