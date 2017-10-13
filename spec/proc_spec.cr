require "./spec_helper"

describe "sarlanga" do
  it "xxxxx" do
      outside = 5
      [0, 1].map_with_index do |e, i|
        outside = e*8+i
      end

      puts outside
  end
end
