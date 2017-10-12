require "yaml"

class CarWithResult
  YAML.mapping(
    car: Car,
    result: Float64,
  )

  def initialize(@car : Car, @result : Float64)
  end

  def car_as_vector
    @car.as_vector
  end

  def result_as_vector
    [@result]
  end
end
