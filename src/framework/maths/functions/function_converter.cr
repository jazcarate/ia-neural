class FunctionConverter
  def self.from_yaml(value : YAML::PullParser) : DifferentiableFunction
    case value.read_string.downcase
    when "sig", "sigmoid"
      Functions::SIGMOID
    else
      Functions::ID
    end
  end
end
