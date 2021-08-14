require_relative './bgg/main.rb'

class Window < BGG::Window
  def initialize
    super(width: 320, height: 240, caption: 'my game')
    set_escape_key(Gosu::KB_ESCAPE)
  end

  def update

  end
end

Window.new.show