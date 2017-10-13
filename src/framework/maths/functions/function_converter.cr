class FunctionConverter
  def self.from_yaml(value : YAML::PullParser) : DifferentiableFunction
    case value.read_scalar.downcase
    when "sig", "sigmoid"
      Functions::SIGMOID
    else
      Functions::ID
    end
  end
end
