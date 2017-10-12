require "logger"
require "./ia-neural"

input = Matrix(Float64).from [[6.2, 3.4, 5.4, 2.3]]
weights = Matrix(Float64).from [[-1.3009441313561163], [-1.1996259436575056], [2.753149093430228], [1.7750763244779555]]

puts (input.x weights).map(LearningMaths.sigmoid).to_s
