require "./spec_helper"

describe CarFactory do
  it "should be able output a correct car" do
    car = CarFactory.random

    car.should be_a CarWithResult
  end

  it "an old car wont pass" do
    car = Car.new year: 3.0, model: 3.0, prev_result: 1.0

    CarFactory.evaluate(car).should be_a CarFactory::RESULT::REJECTED
  end


  context "a car from earlier models will deteriorate" do
    it "from aproved to conditional" do
      car = Car.new year: 7.0, model: 3.0, prev_result: 1.0

      CarFactory.evaluate(car).should be_a CarFactory::RESULT::CONDITIONAL
    end

    it "from conditional to rejected" do
      car = Car.new year: 7.0, model: 3.0, prev_result: 0.5

      CarFactory.evaluate(car).should be_a CarFactory::RESULT::REJECTED
    end
  end

  context "latter models will be allways pass" do
    it "if it passed earlier" do
      car = Car.new year: 7.0, model: 5.0, prev_result: 1.0

      CarFactory.evaluate(car).should be_a CarFactory::RESULT::APPROVED
    end

    it "even if it failed the last inspection" do
      car = Car.new year: 7.0, model: 5.0, prev_result: 0.0

      CarFactory.evaluate(car).should be_a CarFactory::RESULT::APPROVED
    end
  end
end
