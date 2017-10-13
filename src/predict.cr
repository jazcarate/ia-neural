require "./ia-neural"

weights_path = ARGV[0].nil? ? "./out/weights_data.yaml" : ARGV[0]
weights = Array(Matrix(Float64)).from_yaml( File.read weights_path )
input = (Vector(Float64).from_json(ARGV[1])).as_matrix
expected_value = ARGV[2].to_f


l1 = (input.x weights[0]).map(LearningMaths.sigmoid)
l2 = (l1.x weights[1]).map(LearningMaths.sigmoid)[0][0]

puts "Diferencia entre el resultado #{l2} y #{expected_value}: #{expected_value - l2}"
