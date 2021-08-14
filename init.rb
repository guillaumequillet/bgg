require_relative './bgg/main.rb'

class Window < BGG::Window
  def initialize
    super(width: 640, height: 480, caption: 'my game')
    set_escape_key(Gosu::KB_ESCAPE)
    set_mouse_icon('./gfx/cursor.png')
  end

  def update

  end

  def draw
    super

    @aabb ||= BGG::AABB.new(origin: BGG::Vector.new(x: 10, y: 10), size: BGG::Vector.new(x: 100, y: 100))
    
    mouse = BGG::AABB.new(origin: BGG::Vector.new(x: self.mouse_x, y: self.mouse_y), size: BGG::Vector.new(x: 10, y: 10))

    color = @aabb.collides?(mouse) ? Gosu::Color::RED : Gosu::Color::WHITE
    @aabb.draw(color: color, style: :solid)
    mouse.draw(color: Gosu::Color::GREEN)
  end
end

Window.new.show