require "./ia-neural"
require "yaml"

# La idea es generar información sobre:
# Año del vehículo
# Modelo del vehículo
# Resultado de verificaciones anteriores

# y dada esta información determinar la correlación sobre el resultado de:
# Aprobado, Condicional o Rechazado



config_path = ARGV.size == 0 ? "./out/test_data.yaml" : ARGV[0]


cars = [CarWithResult.new(Car.new(2017.0, 4.0, 0.4), 0.4),
        CarWithResult.new(Car.new(2015.0, 4.0, 0.9), 0.2),
        CarWithResult.new(Car.new(2015.0, 4.0, 0.2), 0.2),
        CarWithResult.new(Car.new(2016.0, 4.0, 0.1), 0.1)]

File.open(config_path, "w") { |f| cars.to_yaml(f) }
