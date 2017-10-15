require "./spec_helper"

describe "All the thigs" do
  it "should be able output a correct car" do
    cars = Array.new(2) { CarFactory.random() }


    input = Matrix(Float64).from( cars.map &.car_as_vector )
    results = Matrix(Float64).from( cars.map &.result_as_vector )

    specs = NetworkSpecs.new [3, 1], Functions::SIGMOID, 3

    network = Network.new specs
    weights = network.compute input, results

    one_result = Matrix(Float64).from [[2004.0, 3.0,1.0]]

    output = network.predict(one_result, weights).last[0][0]

    (output).should be_close(0.0, 0.1)
  end
end
