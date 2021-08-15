=begin
  TODO 
  voir ce qu'on pourrait faire avec les objets Tiled, du coup ! (type / nom / autre propriété)
  y a clairement moyen de gérer teleport, shop, inn et blocks
=end

require_relative './bgg/main.rb'

class Window < BGG::Window
  def initialize
    super(width: 640, height: 480, caption: 'my game')
    set_escape_key(Gosu::KB_ESCAPE)
    hide_mouse_cursor
    @map = BGG::TiledMap.new(filename: './gfx/test.json', display: :view_3d)
    @camera = BGG::Camera3D.new(position: BGG::Vector.new(x: 0, y: 16, z: 32))
  end

  def button_down(id)
    super
    @map = BGG::TiledMap.new(filename: './gfx/test.json', display: :view_3d) if id == Gosu::KB_SPACE
  end

  def update
    super
    @camera.update
  end

  def draw
    super
    gl do
      @camera.look
      @map.draw_3D(@camera)
    end
  end
end

Window.new.show
