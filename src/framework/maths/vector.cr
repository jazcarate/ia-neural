require "json"

class Vector(T)
  JSON.mapping(
    data: Array(T)
  )

  def as_matrix
    Matrix(T).from [data]
  end
end
