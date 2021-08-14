require_relative './bgg/main.rb'

class Window < BGG::Window
  def initialize
    super(width: 640, height: 480, caption: 'my game')
    set_escape_key(Gosu::KB_ESCAPE)
    hide_mouse_cursor
    @map = BGG::TiledMap.new('./gfx/test.json')
  end

  def update
    super
  end

  def draw
    super
    scale(2, 2) do
      @map.draw
    end
  end
end

Window.new.show
