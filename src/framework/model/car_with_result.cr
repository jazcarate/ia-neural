require "yaml"

class CarWithResult
  YAML.mapping(
    car: Car,
    result: Float64,
  )

  def initialize(@car : Car, @result : Float64)
  end
end
