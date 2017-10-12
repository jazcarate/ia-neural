require "./spec_helper"

describe Matrix do
  it "should be able to add vectors" do
    m1 = Matrix(Float64).from [[-5.0, 2.0],
                               [2.0, 8.0]]

    m2 = Matrix(Float64).from [[-2.0, 6.0],
                               [1.0, 3.0]]
    r = m1+m2

    r[0,0].should be_close(-7, 0.01); r[0,1].should be_close(8, 0.01)
    r[1,0].should be_close(3, 0.01); r[1,1].should be_close(11, 0.01)
  end

  it "should be able to substract vectors" do
    m1 = Matrix(Float64).from [[-5.0, 2.0],
                               [2.0, 8.0]]

    m2 = Matrix(Float64).from [[-2.0, 6.0],
                               [1.0, 3.0]]
    r = m1-m2

    r[0,0].should be_close(-3, 0.01); r[0,1].should be_close(-4, 0.01)
    r[1,0].should be_close(1, 0.01); r[1,1].should be_close(5, 0.01)
  end

  it "should be able to multiply vectors" do
    m1 = Matrix(Float64).from [[-5.0, 2.0],
                               [2.0, 8.0]]

    m2 = Matrix(Float64).from [[-2.0, 6.0],
                               [1.0, 3.0]]
    r = m1*m2

    r[0,0].should be_close(10, 0.01); r[0,1].should be_close(12, 0.01)
    r[1,0].should be_close(2, 0.01); r[1,1].should be_close(24, 0.01)
  end

  it "should be able to multiply cross vectors" do
    #https://www.wolframalpha.com/input/?i=%7B%7B-1,+2,+4%7D%7D+.+%7B%7B-1%7D,%7B-3%7D,%7B2%7D%7D
    m1 = Matrix(Float64).from [[-1.0, 2.0, 4.0]]

    m2 = Matrix(Float64).from [[-1.0],
                               [-3.0],
                               [2.0]]
    r = m1.x m2

    r[0,0].should be_close(3, 0.01);
  end

  it "should not be able to multiply wrongly sized matrixs" do
    m1 = Matrix(Float64).from [[-2.0, 0.0]]

    m2 = Matrix(Float64).from [[-5.0, 2.0],
                               [2.0, 8.0],
                               [1.0, 4.0]]

      expect_raises(Exception) do
        m1*m2
      end
  end

  it "should be able to transpose a matrix" do
    m = Matrix(Float64).from([[-5.0, 2.0],
                               [2.0, 8.0],
                               [1.0, 4.0]])
     r = m.t

    r[0,0].should be_close(-5.0, 0.01)
    r[1,0].should be_close(2.0, 0.01)

    r[0,1].should be_close(2.0, 0.01)
    r[1,1].should be_close(8.0, 0.01)

    r[0,2].should be_close(1.0, 0.01)
    r[1,2].should be_close(4.0, 0.01)
  end

  it "can map each element with a function" do
    m = Matrix(Float64).from([[-5.0, 2.0],
                               [2.0, 8.0],
                               [1.0, 4.0]])

   r = m.map ->(x : Float64) { x * 2 }
   r[0,0].should be_close(-10.0, 0.01)
   r[1,0].should be_close(4.0, 0.01)
   r[2,0].should be_close(2.0, 0.01)

   r[0,1].should be_close(4.0, 0.01)
   r[1,1].should be_close(16.0, 0.01)
   r[2,1].should be_close(8.0, 0.01)
  end
end
