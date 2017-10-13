require "./ia-neural"

input_path = ARGV.size == 0 ? "./out/test_data.yaml" : ARGV[0]
output_path = ARGV.size < 1 ? "./out/weights_data.yaml" : ARGV[1]

puts "Leyendo la información de #{input_path}"
cars = Array(CarWithResult).from_yaml( File.read input_path )

input = Matrix(Float64).from( cars.map &.car_as_vector )
results = Matrix(Float64).from( cars.map &.result_as_vector )


spec = NetworkSpecs.new [3, 4, 2, 1], Functions::SIGMOID, 500000
File.open("network_specs.yaml", "w") { |f| YAML.dump(spec, f) }

n = Network.new spec
weights = n.compute input, results

File.open(output_path, "w") { |f| weights.to_yaml(f) }
puts "Done! pesos: #{output_path}"
