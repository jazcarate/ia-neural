require "./ia-neural"

config_path = ARGV.size == 0 ? "./out/test_data.yaml" : ARGV[0]
cars = Array(CarWithResult).from_yaml( File.read config_path )

require "./ia-neural"

config_path = ARGV.size == 0 ? "./out/test_data.yaml" : ARGV[0]
cars = Array(CarWithResult).from_yaml( File.read config_path )

input = Matrix(Float64).from( cars.map &.car_as_vector )
results = Matrix(Float64).from( cars.map &.result_as_vector )


wheights = Network.new.compute input, results

puts wheights.to_yaml
