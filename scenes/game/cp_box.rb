class CPBox < CPBase
  COLLISION_TYPE = 0
  attr_accessor :body, :shape

  def initialize(x, y, width, height, mass, color, image = nil, e = 10, u = 0.1)
    verts = [CP::Vec2.new(-width/2, -height/2),
             CP::Vec2.new(-width/2, height/2),
             CP::Vec2.new(width/2, height/2),
             CP::Vec2.new(width/2, -height/2)]
    moment = 100000000000
    @body = CP::Body.new(mass, moment)
    @body.p = CP::Vec2.new(x + width / 2, y + height / 2)
    @shape = CP::Shape::Poly.new(@body, verts, CP::Vec2.new(0, 0))
    @shape.collision_type = self.class::COLLISION_TYPE
    @shape.parent_obj = self
    @image = image || Image.new(width, height, color)
    @x, @y = x, y
    @width, @height = width, height
    shape.e = e
    shape.u = u
  end

  def move
  end

  def draw
    Window.draw_rot(@body.p.x - @width / 2, @body.p.y - @height / 2, @image, @body.p.to_angle * 180.0)
  end
end