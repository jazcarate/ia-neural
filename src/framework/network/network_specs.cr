class NetworkSpecs
  YAML.mapping(
    topology: Array(Int32),
    function: {type: DifferentiableFunction, converter: FunctionConverter},
    generations: Int32
  )

  def initialize(@topology, @function, @generations = 5000)

  end

  def layers
    @topology.size
  end
end
