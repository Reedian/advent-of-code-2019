class Moon
  class Point
    attr_accessor :x, :y, :z

    def initialize(x:, y:, z:)
      @x = x.to_i
      @y = y.to_i
      @z = z.to_i
    end

    def to_s
      "<x=#{x} y=#{y} z=#{z}>"
    end
  end

  attr_reader :position, :velocity

  def initialize(position)
    @position = Point.new(x: position[0], y: position[1], z: position[2])
    @velocity = Point.new(x: 0, y: 0, z: 0)
  end

  def apply_velocity
    position.x += velocity.x
    position.y += velocity.y
    position.z += velocity.z
  end

  def to_s
    "pos=#{position.to_s}, vel=#{velocity.to_s}"
  end

  def dup
    self.class.new([position.x, position.y, position.z])
  end
end
