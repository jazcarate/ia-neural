class Network
  def initialize(@network_spec : NetworkSpecs)
      @log = Logger.new(STDOUT)
      @log.level = Logger::INFO
  end

  def compute(input, results)
    syn0 = Matrix(Float64).new 3,4 {Random.rand}
    syn1 = Matrix(Float64).new 4,1 {Random.rand}

    gen = 1
    while gen < 60000
      @log.debug("--- Generation #{gen} ---")

      l0 = input
      l1 = (l0.x syn0).map(@network_spec.function.fn)
      l2 = (l1.x syn1).map(@network_spec.function.fn)
      @log.debug("Prediction:\t\t #{l2.to_s}")

      l2_error = results - l2
      @log.debug("Prediction layer 2 error:\t #{l2_error.to_s}")

      if gen % 10000 == 0
        @log.info "Suma de errores parciales: #{l2_error.clone.flatten.map(&.abs).sum}"
      end

      l2_delta = l2_error * l2.map(@network_spec.function.fn_d)
      @log.debug("Prediction layer 2 delta:\t #{l2_delta.to_s}")

      l1_error = l2_delta.x syn1.t
      @log.debug("Prediction layer 1 error:\t #{l1_error.to_s}")

      l1_delta = l1_error * l1.map(@network_spec.function.fn_d)
      @log.debug("Prediction layer 1 delta:\t #{l1_delta.to_s}")


      syn1 += l1.t.x l2_delta
      syn0 += l0.t.x l1_delta
      @log.debug("new syn0:\t #{syn0.to_s}")
      @log.debug("new syn1:\t #{syn1.to_s}")

      gen += 1
    end
    [syn0, syn1]
  end

end
