require "./ia-neural"
require "option_parser"

input_path = "./config/test_data.yaml"
network_path = "./config/network_specs.yaml"
output_path = "./config/network_specs.yaml"
input_string = "1.0, 2.0, 3.0"
expected_value = 0.0

OptionParser.parse! do |parser|
  parser.banner = "Usage: learn [-i PATH][-n PATH][-o PATH]"
  parser.on("-i PATH", "--input=PATH", "Path a la entrada a entrenar (posiblemente generados por `generate`)")  { |path| input_path = path }
  parser.on("-n PATH", "--network=PATH", "Path a la configuración de la red neuronal")  { |path| network_path = path }
  parser.on("-o PATH", "--output=PATH", "Path de la salida de los pesos") { |path| output_path = input }
  parser.on("-h", "--help", "Mostrar esta ayuda") { puts parser }
end


puts "Leyendo la información de #{input_path}"
cars = Array(CarWithResult).from_yaml( File.read input_path )

input = Matrix(Float64).from( cars.map &.car_as_vector )
results = Matrix(Float64).from( cars.map &.result_as_vector )

puts "Leyendo la especificación de la red de #{network_spec}"
spec = NetworkSpecs.from_yaml( File.read network_path )

n = Network.new spec
weights = n.compute input, results

File.open(output_path, "w") { |f| weights.to_yaml(f) }
puts "Done! pesos guardados en: #{output_path}"
