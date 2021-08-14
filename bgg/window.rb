module BGG
  class Window < Gosu::Window
    MOUSE_Z = 10000
    def initialize(width: 640, height: 480, fullscreen: false, caption: 'untitled')
      @width, @height, @fullscreen, @caption = width, height, fullscreen, caption
      super(@width, @height, @fullscreen)
      self.caption = @caption
      @keys = Hash.new
      @needs_cursor = true
    end

    def set_escape_key(key)
      @keys[:escape] = key
    end

    def set_mouse_icon(gosu_image)
      @mouse_icon = gosu_image.is_a?(Gosu::Image) ? gosu_image : Gosu::Image.new(gosu_image, retro: true)
    end

    def hide_mouse_cursor; @needs_cursor = false; end

    def show_mouse_cursor; @needs_cursor; true
    end

    def needs_cursor?
      return false if defined?(@mouse_icon)
      @needs_cursor
    end

    def button_down(id)
      self.close! if @keys.has_key?(:escape) && id == @keys[:escape]
    end

    def draw
      if defined?(@mouse_icon) && @needs_cursor
        @mouse_icon.draw_rot(self.mouse_x, self.mouse_y, MOUSE_Z, 0)
      end
    end
  end
end
