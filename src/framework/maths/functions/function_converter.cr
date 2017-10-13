class FunctionConverter
  def self.from_json(value : JSON::PullParser) : Time
    case value.read_string.downcase
    when "sig", "sigmoid"
      Functions::SIGMOID
    else
      Functions::ID
    end
  end
end
