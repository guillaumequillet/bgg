module BGG
  class Camera3D
    attr_accessor :angles, :position, :target
    def initialize(position: Vector.new, target: Vector.new, fovy: 45.0, distance: 64, type: :fps)
      @position, @target, @fovy = position, target, fovy
      @angles = Vector.new
      @distance = distance
      @near, @far = 1, 1000
      @type = type # :fps or :tps
    end
    
    def update
      # double r_temp = cos(_phi*M_PI/180);
      # _forward.Z = sin(_phi*M_PI/180);
      # _forward.X = r_temp*cos(_theta*M_PI/180);
      # _forward.Y = r_temp*sin(_theta*M_PI/180);

      case @type
      when :fps
        r_temp = Math.cos(@angles.y * Math::PI / 180.0)
        @target.y = @position.y + @distance * Math.sin(@angles.y * Math::PI / 180.0)
        @target.x = @position.x + @distance * r_temp * Math.cos(@angles.x * Math::PI / 180.0)
        @target.z = @position.z + @distance * r_temp * Math.sin(@angles.x * Math::PI / 180.0)
      end
    end

    def look
      glEnable(GL_DEPTH_TEST)
      glEnable(GL_TEXTURE_2D)
      glMatrixMode(GL_PROJECTION)
      glLoadIdentity
      ratio = BGG.window_fullscreen ? (Gosu::screen_width.to_f / Gosu::screen_height.to_f) : BGG.window_width.to_f / BGG.window_height
      gluPerspective(@fovy, ratio, @near, @far)
      glMatrixMode(GL_MODELVIEW)
      glLoadIdentity
      gluLookAt(@position.x, @position.y, @position.z, @target.x, @target.y, @target.z, 0, 1, 0)
    end
  end
end
