require "./spec_helper"

describe "All the thigs" do
  it "should be able output a correct car" do
    a_car = CarFactory.random()

    input = Matrix(Float64).from( [a_car.car_as_vector] )
    results = Matrix(Float64).from( [a_car.result_as_vector] )

    specs = NetworkSpecs.new [3, 4, 1], Functions::SIGMOID, 10000

    network = Network.new specs
    weights = network.compute input, results

    one_result = Matrix(Float64).from [a_car.car_as_vector]

    output = network.predict(one_result, weights)

    (output.last[0, 0]).should be_close(a_car.result, 0.3)
  end
end
