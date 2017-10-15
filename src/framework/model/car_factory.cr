class CarFactory
  enum RESULT
    REJECTED
    CONDITIONAL
    APPROVED
  end


  def self.random()
    car = Car.new((int_random from: 0, to: 10),
                  (int_random from: 1, to: 5),
                  (int_random from: RESULT::REJECTED.value, to: RESULT::APPROVED.value))
    CarWithResult.new(car, transform evaluate(car).value.to_f)
  end

  def self.int_random(from, to)
    transform (Random.new.rand(to-from)+from).to_f
  end

  def self.transform(v)
    v/10
  end


  # If the car is older than 2010, it will fail
  # Models 1, 2 and 3 depend on the last result
  # - Condifionals and Rejected will end up rejected; and aproved will drop to conditional
  # Model 4 and 5 will allyas be aproved

  def self.evaluate(car)
    if car.year > 0.5
      RESULT::REJECTED
    elsif car.model <= 0.3
      if car.prev_result > RESULT::CONDITIONAL.value
        RESULT::REJECTED
      else
        RESULT::CONDITIONAL
      end
    else
      RESULT::APPROVED
    end
  end

end
