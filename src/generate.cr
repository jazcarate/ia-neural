require "./ia-neural"
require "option_parser"

# La idea es generar información sobre:
# Año del vehículo
# Modelo del vehículo
# Resultado de verificaciones anteriores

# y dada esta información determinar la correlación sobre el resultado de:
# Aprobado, Condicional o Rechazado


verbose = false
output_path = "./config/test_data.yaml"
generation_amount = 5

OptionParser.parse! do |parser|
  parser.banner = "Usage: generate [-n CANTIDAD][-o OUTPUT][-v]"
  parser.on("-n CANTIDAD", "--number=CANTIDAD", "Cantidad de la población a generar")  { |amount| generation_amount = amount.to_i }
  parser.on("-o PATH", "--output=PATH", "Path de la salida de la información generada") { |path| output_path = path }
  parser.on("-v", "--verbose", "imprimir resultado por pantalla") { verbose = true }
  parser.on("-h", "--help", "Mostrar esta ayuda") { puts parser }
end

cars = Array.new(generation_amount) { CarFactory.random() }

puts cars.to_yaml if verbose

File.open(output_path, "w") { |f| cars.to_yaml(f) }
puts "Done! datos: #{output_path}"
