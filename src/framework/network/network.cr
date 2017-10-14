class Network
  def initialize(@network_spec : NetworkSpecs)
      @log = Logger.new(STDOUT)
      @log.level = Logger::INFO
  end

  def setup_random_synapsys(topology)
    synapsys = [] of Matrix(Float64)
    topology.each_cons(2) do |cons|
      synapsys << Matrix(Float64).new cons[0], cons[1] {Random.rand}
    end
    synapsys
  end

  def predict(input, synapsys)
    acc = input
    predictions = synapsys.map do |syn|
      acc = (acc.x syn).map(@network_spec.function.fn)
    end
    predictions.unshift(input)
  end

  def compute(input, results)
    synapsys = setup_random_synapsys @network_spec.topology

    gen = 1
    while gen < @network_spec.generations
      @log.debug("--- Generation #{gen} ---")

      # Forward Prediction
      predictions = predict input, synapsys
      predictions.unshift(input)

      @log.debug("Prediccion :\t\t #{predictions.last.to_s}")

      error = results - predictions.last

      if gen % 10000 == 0
        @log.debug "Partial error sum: #{error.flatten.map(&.abs).sum}"
      end


      # Back Propagation
      i = synapsys.size-1
      last_error = error
      deltas = [] of Matrix(Float64)
      while i >= 0
        delta = last_error * predictions[i+1].map(@network_spec.function.fn_d)
        deltas << delta
        last_error = delta.x synapsys[i].t

        i -= 1
      end

      i = 0
      while i < predictions.size-1
        synapsys[i] += predictions[i].t.x deltas.reverse[i]

        i += 1
      end

      gen += 1
    end
    synapsys
  end

end
