module BGG
  class Texture
    def initialize(filename)
      gosu_image = Gosu::Image.new(filename, retro: true)
      array_of_pixels = gosu_image.to_blob
      tex_name_buf = ' ' * 4
      glGenTextures(1, tex_name_buf)
      @tex_name = tex_name_buf.unpack('L')[0]
      glBindTexture( GL_TEXTURE_2D, @tex_name )
      glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, gosu_image.width, gosu_image.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, array_of_pixels)
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)
      gosu_image = nil
    end

    def get_id
      return @tex_name
    end
  end
end
