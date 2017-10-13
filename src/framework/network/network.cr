class Network
  def initialize(@network_spec : NetworkSpecs)
      @log = Logger.new(STDOUT)
      @log.level = Logger::DEBUG
  end

  def setup_synapsys(topology)
    synapsys = [] of Matrix(Float64)
    topology.each_cons(2) do |cons|
      synapsys << Matrix(Float64).new cons[0], cons[1] {Random.rand}
    end
    synapsys
  end

  def compute(input, results)
    synapsys = setup_synapsys @network_spec.topology

    gen = 1
    while gen < @network_spec.generations
      @log.debug("--- Generation #{gen} ---")

      # Forward Prediction
      acc = input
      predictions = synapsys.map do |syn|
        acc = (acc.x syn).map(@network_spec.function.fn)
      end

      @log.debug("Prediccion :\t\t #{predictions.last.to_s}")

      error = results - predictions.last

      if gen % 10000 == 0
        @log.debug "Partial error sum: #{error.flatten.map(&.abs).sum}"
      end

      # Back Propagation
      last_delta = Matrix(Float64).new 1, 1 # Should never be used
      deltas = synapsys.reverse.map_with_index do |syn, index|
        @log.debug "\n#{index}\t last_delta:\t #{last_delta.to_s}"

        if index == 0
          local_error = error
        else
          local_error = last_delta.x syn.t
        end

        last_delta = local_error * predictions.reverse[index].map(@network_spec.function.fn_d)
        @log.debug "Prediction layer #{-index+(@network_spec.layers-1)} delta:\t #{last_delta.to_s} with #{local_error.to_s} error"
        last_delta.clone
      end

      synapsys = synapsys.zip(deltas).map_with_index do |syn_delta, index|
        syn = syn_delta.first
        delta = syn_delta.last

        new_syn = syn.t.x delta
        @log.debug("New syn#{index}:\t #{new_syn.to_s}")
        new_syn
      end

      gen += 1
    end
    synapsys
  end

end
