class NetworkSpecs
  YAML.mapping(
    topology: Array(Int32),
    function: {type: DifferentiableFunction, converter: FunctionConverter}
  )

  def initialize(@topology, @function)

  end
end
