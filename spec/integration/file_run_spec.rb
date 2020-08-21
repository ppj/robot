# frozen_string_literal: true

RSpec.describe "File Runs" do
  context "Example 1" do
    it "works" do
      expect(`./run.rb ./spec/integration/fixtures/example1`.chomp).to eq("ALICE: 0,1,NORTH")
    end
  end

  context "Example 2" do
    it "works" do
      expect(`./run.rb ./spec/integration/fixtures/example2`.chomp).to eq("BOB: 0,0,WEST")
    end
  end

  context "Example 3" do
    it "works" do
      expect(`./run.rb ./spec/integration/fixtures/example3`.chomp).to eq("ALICE: 3,3,NORTH\nBOB: 4,2,SOUTH")
    end
  end

  context "Example 4" do
    it "works" do
      expect(`./run.rb ./spec/integration/fixtures/example4`.chomp).to eq("ALICE: 2,1,EAST\nBOB: 1,1,EAST")
    end
  end
end
