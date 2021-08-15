module BGG
  def self.mouse_x; @@mouse_x; end
  def self.mouse_y; @@mouse_y; end
  def self.window_width; @@window_width; end
  def self.window_height; @@window_height; end
  def self.window_fullscreen; @@window_fullscreen; end

  def self.set_mouse_coordinates(x: 0, y: 0)
    @@mouse_x = x
    @@mouse_y = y
  end

  def self.set_window_size(width: 0, height: 0, fullscreen: false)
    @@window_width = width
    @@window_height = height
    @@window_fullscreen = fullscreen
  end

  class Window < Gosu::Window
    MOUSE_Z = 10000
    def initialize(width: 640, height: 480, fullscreen: false, caption: 'untitled', resizable: false)
      @width, @height, @fullscreen, @caption = width, height, fullscreen, caption
      super(@width, @height, { fullscreen: @fullscreen, resizable: resizable })
      self.caption = @caption
      @keys = Hash.new
      @needs_cursor = true
      BGG.set_window_size(width: self.width, height: self.height, fullscreen: self.fullscreen?)
    end

    def set_escape_key(key)
      @keys[:escape] = key
    end

    def set_mouse_icon(gosu_image)
      @mouse_icon = gosu_image.is_a?(Gosu::Image) ? gosu_image : Gosu::Image.new(gosu_image, retro: true)
    end

    def hide_mouse_cursor; @needs_cursor = false; end

    def show_mouse_cursor; @needs_cursor = true; end

    def needs_cursor?
      return false if defined?(@mouse_icon)
      @needs_cursor
    end

    def button_down(id)
      super
      self.close! if @keys.has_key?(:escape) && id == @keys[:escape]

      if id == Gosu::KB_F11 # fullscreen toggle
        BGG.set_window_size(width: self.width, height: self.height, fullscreen: self.fullscreen?)
      end
    end

    def update_mouse_coordinates
      BGG.set_mouse_coordinates(x: self.mouse_x, y: self.mouse_y)
    end

    def update
      update_mouse_coordinates
    end

    def fill_with_color(color = Gosu::Color::WHITE)
      Gosu.draw_rect(0, 0, self.width, self.height, color)
    end

    def draw
      if defined?(@mouse_icon) && @needs_cursor
        @mouse_icon.draw_rot(self.mouse_x, self.mouse_y, MOUSE_Z, 0)
      end
    end
  end
end
