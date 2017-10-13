require "./ia-neural"

input_path = ARGV.size == 0 ? "./out/test_data.yaml" : ARGV[0]
output_path = ARGV.size < 1 ? "./out/weights_data.yaml" : ARGV[1]

puts "Leyendo la información de #{input_path}"
cars = Array(CarWithResult).from_yaml( File.read input_path )

input = Matrix(Float64).from( cars.map &.car_as_vector )
results = Matrix(Float64).from( cars.map &.result_as_vector )

weights = Network.new.compute input, results

File.open(output_path, "w") { |f| weights.to_yaml(f) }
puts "Done! pesos: #{output_path}"
