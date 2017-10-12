require "logger"
require "./ia-neural"



yaml = YAML.parse(File.read config_path)

input = Matrix(Float64).from [[0.0,0.0,1.0],
                              [0.0,1.0,1.0],
                              [1.0,0.0,1.0],
                              [1.0,1.0,1.0]]

results = Matrix(Float64).from [[0.0],
                                [1.0],
                                [1.0],
                                [0.0]]

Network.new
