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
    @map = BGG::TiledMap.new('./gfx/test_autotile.json')
    @camera = BGG::Camera3D.new(position: BGG::Vector.new(x: 0, y: 16, z: 32))
  end

  def update
    super
    @camera.update
  end

  def draw
    super
    gl do
      @camera.look
      @camera.angles.x += 0.2
      glDisable(GL_TEXTURE_2D)
      glPushMatrix
      glScalef(128, 128, 128)
      glBegin(GL_QUADS)
        glVertex3f(0, 0, 0)
        glVertex3f(0, 0, 1)
        glVertex3f(1, 0, 1)
        glVertex3f(1, 0, 0)
      glEnd
      glPopMatrix
    end
  end
end

Window.new.show
