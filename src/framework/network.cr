class Network
  def initialize
      @log = Logger.new(STDOUT)
      @log.level = Logger::ERROR
  end

  def compute(input, results)
    syn0 = Matrix(Float64).new 3,4 {Random.rand}
    syn1 = Matrix(Float64).new 4,1 {Random.rand}

    gen = 1
    while gen < 100
      @log.info("--- Generation #{gen} ---")

      l0 = input
      l1 = (l0.x syn0).map(LearningMaths.sigmoid)
      l2 = (l1.x syn1).map(LearningMaths.sigmoid)
      @log.info("Prediction:\t\t #{l2.to_s}")

      l2_error = results - l2
      @log.info("Prediction layer 2 error:\t #{l2_error.to_s}")

      if gen % 10000 == 0
        puts l2_error.clone.flatten.map(&.abs).sum
      end

      l2_delta = l2_error * l2.map(LearningMaths.sigmoid_d)
      @log.info("Prediction layer 2 delta:\t #{l2_delta.to_s}")

      l1_error = l2_delta.x syn1.t
      @log.info("Prediction layer 1 error:\t #{l1_error.to_s}")

      l1_delta = l1_error * l1.map(LearningMaths.sigmoid_d)
      @log.info("Prediction layer 1 delta:\t #{l1_delta.to_s}")


      syn1 += l1.t.x l2_delta
      syn0 += l0.t.x l1_delta
      @log.info("new syn0:\t #{syn0.to_s}")
      @log.info("new syn1:\t #{syn1.to_s}")

      gen += 1
    end
    [syn0, syn1]
  end

end
