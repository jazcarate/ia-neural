require "yaml"

class Car
  YAML.mapping(
    year: Float64,
    model: Float64,
    prev_result: Float64,
  )

  def initialize(@year : Float64, @model : Float64, @prev_result : Float64)
  end
end
