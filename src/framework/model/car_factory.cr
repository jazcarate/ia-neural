class CarFactory
  enum RESULT
    REJECTED
    CONDITIONAL
    APPROVED
  end


  def self.random()
    car = Car.new((int_random from: 2000, to: 2017),
                  (int_random from: 1, to: 5),
                  (int_random from: RESULT::REJECTED.value, to: RESULT::APPROVED.value))
    CarWithResult.new(car, evaluate(car).value.to_f)
  end

  def self.int_random(from, to)
    (Random.new.rand(to-from)+from).to_f
  end


  # If the car is older than 2010, it will fail
  # Models 1, 2 and 3 depend on the last result
  # - Condifionals and Rejected will end up rejected; and aproved will drop to conditional
  # Model 4 and 5 will allyas be aproved

  def self.evaluate(car)
    if car.year < 2010
      RESULT::REJECTED
    elsif car.model <= 3
      if car.prev_result > 0.5 #Conditional
        RESULT::REJECTED
      else
        RESULT::CONDITIONAL
      end
    else
      RESULT::APPROVED
    end
  end

end
