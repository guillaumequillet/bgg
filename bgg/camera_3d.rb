module BGG
  class Camera3D
    attr_accessor :angles, :position, :target
    def initialize(position: Vector.new, target: Vector.new, fovy: 45.0, distance: 64, type: :fps)
      @position, @target, @fovy = position, target, fovy
      @angles = Vector.new(x: 0, y: 0, z: 0)
      @distance = distance
      @near, @far = 1, 1000
      @type = type # :fps or :tps
    end
    
    def update
      r_temp = Math.cos(@angles.y * Math::PI / 180.0)
      vectors = Vector.new(
        x: r_temp * Math.cos(@angles.x * Math::PI / 180.0),
        y: Math.sin(@angles.y * Math::PI / 180.0),
        z: r_temp * Math.sin(@angles.x * Math::PI / 180.0)
      )
      straff_vectors = Vector.new(
        x: r_temp * Math.cos((@angles.x - 90.0) * Math::PI / 180.0),
        y: Math.sin(@angles.y * Math::PI / 180.0),
        z: r_temp * Math.sin((@angles.x - 90.0) * Math::PI / 180.0)
      )
      
      # position update
      v = 1.2
      if Gosu.button_down?(Gosu::KB_W)
        @position.x += v * vectors.x
        @position.z += v * vectors.z
      elsif Gosu.button_down?(Gosu::KB_S)
        @position.x -= v * vectors.x
        @position.z -= v * vectors.z
      end

      if Gosu.button_down?(Gosu::KB_A)
        @position.x += v * straff_vectors.x
        @position.z += v * straff_vectors.z
      elsif Gosu.button_down?(Gosu::KB_D)
        @position.x -= v * straff_vectors.x
        @position.z -= v * straff_vectors.z
      end

      # view update
      angle_speed = 1.4
      @angles.x += angle_speed if Gosu.button_down?(Gosu::KB_RIGHT)
      @angles.x -= angle_speed if Gosu.button_down?(Gosu::KB_LEFT)

      case @type
      when :fps
        @target.y = @position.y + @distance * vectors.y
        @target.x = @position.x + @distance * vectors.x
        @target.z = @position.z + @distance * vectors.z
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
