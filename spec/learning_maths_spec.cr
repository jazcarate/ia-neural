require "./spec_helper"

describe Sigmoid do
  it "should be able to sigmoid" do
    Functions::SIGMOID.fn.call(-6.0).should be_close(0, 0.01)
    Functions::SIGMOID.fn.call(0.0).should be_close(0.5, 0.01)
    Functions::SIGMOID.fn.call(6.0).should be_close(1, 0.01)
  end

  it "should be able to derive sigmoid" do
    Functions::SIGMOID.fn_d.call(-6.0).should be_close(-42, 0.01)
    Functions::SIGMOID.fn_d.call(-2.0).should be_close(-6, 0.01)
    Functions::SIGMOID.fn_d.call(1.0).should be_close(0, 0.01)
    Functions::SIGMOID.fn_d.call(2.0).should be_close(-2, 0.01)
    Functions::SIGMOID.fn_d.call(6.0).should be_close(-30, 0.01)
  end
end
