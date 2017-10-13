require "./ia-neural"

input_path = ARGV.size == 0 ? "./config/test_data.yaml" : ARGV[0]
network_spec = ARGV.size < 1 ? "./config/network_specs.yaml" : ARGV[1]
output_path = ARGV.size < 2 ? "./out/weights_data.yaml" : ARGV[2]

puts "Leyendo la información de #{input_path}"
cars = Array(CarWithResult).from_yaml( File.read input_path )

input = Matrix(Float64).from( cars.map &.car_as_vector )
results = Matrix(Float64).from( cars.map &.result_as_vector )

spec = NetworkSpecs.from_yaml( File.read network_spec )

n = Network.new spec
weights = n.compute input, results

File.open(output_path, "w") { |f| weights.to_yaml(f) }
puts "Done! pesos: #{output_path}"
