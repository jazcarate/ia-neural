require "./ia-neural"
require "option_parser"

weights_path = "./out/weights_data.yaml"
network_path = "./config/network_specs.yaml"
input_string = "1.0, 2.0, 3.0"
expected_value = 0.0

OptionParser.parse! do |parser|
  parser.banner = "Usage: predict \"valores a probar\""
  parser.on("-w PATH", "--weights=PATH", "Path a los pesos (posiblemente generados por `learn`)")  { |path| weights_path = path }
  parser.on("-n PATH", "--network=PATH", "Path a la configuración de la red neuronal")  { |path| network_path = path }
  parser.on("-e VALORES", "--expect=VALORES", "Valores a probar") { |valor| expected_value = valor.to_f }
  parser.on("-h", "--help", "Mostrar esta ayuda") { puts parser }
end

input = (Vector(Float64).from_json("{\"data\": [#{ARGV[0]}]}")).as_matrix
spec = NetworkSpecs.from_yaml( File.read network_path )
synapsys = Array(Matrix(Float64)).from_yaml( File.read weights_path )

n = Network.new spec
output = n.predict(input, synapsys).last[0][0]

puts "Diferencia entre el resultado #{output} y #{expected_value}: #{expected_value - output}"
