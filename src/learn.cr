require "logger"
require "./ia-neural"

log = Logger.new(STDOUT)
log.level = Logger::INFO


input = Matrix(Float64).from [[5.1, 3.5, 1.4, 0.2],
                              [4.9, 3.0, 1.4, 0.2],
                              [6.2, 3.4, 5.4, 2.3],
                              [5.9, 3.0, 5.1, 1.8]]

results = Matrix(Float64).from [[0.0],
                                [0.0],
                                [1.0],
                                [1.0]]

weights = Matrix(Float64).new 4,1 {0.5}

gen = 1
while gen < 50
  log.info("--- Generation #{gen} ---")

  pred = (input.x weights).map(LearningMaths.sigmoid)
  log.info("Prediction:\t\t #{pred.to_s}")

  pred_error = results - pred
  log.info("Prediction error:\t #{pred_error.to_s}")

  pred_delta = pred_error * pred.map(LearningMaths.sigmoid_d)
  log.info("Prediction delta:\t #{pred_delta.to_s}")

  weights_delta = input.transpose.x pred_delta
  log.info("weights delta:\t #{weights_delta.to_s}")

  weights = weights + weights_delta
  log.info("new weights:\t #{weights.to_s}")

  gen += 1
end

puts weights.to_s
