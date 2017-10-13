class Id < DifferentiableFunction
  def fn
    ->(x : Float64) { x }
  end

  def fn_d
    ->(x : Float64) { 1.0 }
  end
end
