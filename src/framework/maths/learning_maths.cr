class LearningMaths
  def self.sigmoid
    # función sigmoideal
    # f(x) = 1/(1 + e^-x).

    ->(x : Float64) { 1 / (1 + Math.exp(-x)) }
  end

  def self.sigmoid_d
    # función sigmoid derivada
    # f'(x) = f(x)(1 - f(x)),

    ->(x : Float64) { x * (1-x) }
  end
end
