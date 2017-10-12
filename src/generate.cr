require "./ia-neural"

# La idea es generar información sobre:
# Año del vehículo
# Modelo del vehículo
# Resultado de verificaciones anteriores

# y dada esta información determinar la correlación sobre el resultado de:
# Aprobado, Condicional o Rechazado



config_path = ARGV.size == 0 ? "./out/test_data.yaml" : ARGV[0]

cars = [CarWithResult.new(Car.new(0.0,0.0,1.0), 0.0),
        CarWithResult.new(Car.new(0.0,1.0,1.0), 1.0),
        CarWithResult.new(Car.new(1.0,0.0,1.0), 1.0),
        CarWithResult.new(Car.new(1.0,1.0,1.0), 0.0)]

File.open(config_path, "w") { |f| cars.to_yaml(f) }
puts "Done! file: #{config_path}"
