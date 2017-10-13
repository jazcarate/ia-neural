require "./ia-neural"

spec = NetworkSpecs.new [3, 4, 2, 1], Functions::SIGMOID, 500000
File.open("config/network_specs.yaml", "w") { |f| spec.to_yaml(f) }
