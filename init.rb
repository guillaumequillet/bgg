require_relative './bgg/main.rb'

class Window < BGG::Window
  def initialize
    super(width: 640, height: 480, caption: 'my game')
    set_escape_key(Gosu::KB_ESCAPE)
  end

  def update
    super
  end

  def draw
    super
    fill_with_color(Gosu::Color::RED)
    @aabb ||= BGG::AABB.new(origin: BGG::Vector.new(x: 10, y: 10), size: BGG::Vector.new(x: 100, y: 100))
    color = @aabb.mouse_in? ? Gosu::Color::RED : Gosu::Color::WHITE
    @aabb.draw(color: color, style: :solid)
  end
end

Window.new.show