module BGG
  class Window < Gosu::Window
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

    def hide_mouse_cursor; @needs_cursor = false; end
    def show_mouse_cursor; @needs_cursor = true; end

    def needs_cursor?; @needs_cursor; end

    def button_down(id)
      self.close! if @keys.has_key?(:escape) && id == @keys[:escape]
    end
  end
end
