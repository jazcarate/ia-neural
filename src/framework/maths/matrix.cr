class Matrix(T)
  property data : Array(Array(T))
  property rows : Int32
  property columns : Int32

  def initialize(@rows, @columns)
    @data = Array(Array(T)).new(@rows) { Array(T).new(@columns) { T.new(yield) } }
  end

  def initialize(@rows, @columns, default : T = T.new(0))
    @data = Array(Array(T)).new(@rows) { Array(T).new(@columns) { T.new(default) } }
  end

  def initialize(@rows, @columns, @data)
  end

  def self.from(data : Array(Array(T))) : self
    self.new(data.size, data.first.size, data)
  end

  def ==(matrix : Matrix)
    return false if self.rows != matrix.rows || self.columns != matrix.columns
    self.each_line do |line, x|
      line.each_with_index do |value, y|
        return false if matrix[x][y] != value
      end
    end
    true
  end

  def to_s
    "Matrix{#{dimension}}(#{to_a})"
  end

  def dimension
    rows.to_s + "x" + columns.to_s
  end

  def self.identity(rows, columns) : self
    self.new(rows, columns).tap do |m|
      rows.times do |l|
        columns.times do |c|
          m[l, c] = T.new(1) if l == c
        end
      end
    end
  end

  def clone
    map ->(x : T) { x }
  end

  def +(right : typeof(self)) : typeof(self)
    clone.tap do |m|
      right.data.each_with_index do |line, y|
        line.each_with_index { |cell, x| m[y][x] += cell }
      end
    end
  end

  def -(right : typeof(self)) : typeof(self)
    clone.tap do |m|
      right.data.each_with_index do |line, y|
        line.each_with_index { |cell, x| m[y][x] -= cell }
      end
    end
  end

  def *(right : typeof(self)) : typeof(self)
    clone.tap do |m|
      right.data.each_with_index do |line, y|
        line.each_with_index { |cell, x| m[y][x] *= cell }
      end
    end
  end

  def x(right : Matrix(T)) : typeof(self)
    raise "cannot muliply M1 * M2 if M1.columns != M2.rows (#{self.columns} != #{right.rows})" if self.columns != right.rows
    Matrix(T).new(self.rows, right.columns).tap do |m|
      m.rows.times do |y|
        m.columns.times do |x|
          m[y][x] = self.each_line[y].zip(right.each_column[x]).map { |l, c| l * c }.sum
        end
      end
    end
  end

  def x(right : Number::Primitive) : typeof(self)
    clone.tap { |m| m.flatten_map! { |cell| cell * right } }
  end

  def flatten : Array(T)
    @data.flatten
  end

  def flatten_map! : typeof(self)
    y = 0
    @data.map! { |line| x = 0; line.map { |cell| yield cell, y, x } }
    self
  end

  def transpose : typeof(self)
    clone.tap do |m|
      m.data = m.data.transpose
      m.rows, m.columns = m.columns, m.rows
    end
  end

  def t
    transpose
  end

  def to_a : Array(Array(T))
    @data.to_a
  end

  def map(function : Proc(T, T))
    typeof(self).new(@rows, @columns).tap do |m|
      self.data.each_with_index do |line, y|
        line.each_with_index { |cell, x| m[y][x] = function.call cell }
      end
    end
  end

  def each_line(&b)
    @data.each_with_index { |l, i| yield l, i }
    self
  end

  def each_line : Array(Array(T))
    @data.to_a
  end

  def each_column(&b)
    @data.transpose.each_with_index { |c, i| yield c, i }
    self
  end

  def each_column : Array(Array(T))
    @data.transpose.to_a
  end

  def set_line(idx : Int32, v : Array(T))
    raise "Invalid number of columns passed (#{@columns}, given #{v.size})" if v.size != @columns
    @data[idx] = v
    self
  end

  def set_column(idx : Int32, v : Array(T))
    raise "Invalid number of rows passed (#{@rows}, given #{v.size})" if v.size != @rows
    @data.each_with_index { |_, y| @data[y][idx] = v[y] }
    self
  end

  def [](y : Int32)
    @data[y]
  end

  def [](y : Int32, x : Int32)
    @data[y][x]
  end

  def []=(y : Int32, v : Array(T))
    @data[y] = v
  end

  def []=(y : Int32, x : Int32, v : T)
    @data[y][x] = v
  end
end
