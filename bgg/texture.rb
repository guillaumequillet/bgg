module BGG
  class Texture
    def initialize(filename)
      gosu_image = filename.is_a?(Gosu::Image) ? filename : Gosu::Image.new(filename, retro: true)
      
      # image flip
      gosu_image = Gosu.render(gosu_image.width, gosu_image.height, retro: true) do
        gosu_image.draw_rot(gosu_image.width / 2, gosu_image.height / 2, 0, 0, 0.5, 0.5, 1, -1)
      end
      
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

    def self.load_tiles(filename: '', tile_width: 16, tile_height: 16)
      gosu_images = Gosu::Image.load_tiles(filename, tile_width, tile_height, retro: true)
      textures = []
      gosu_images.each {|gosu_image| textures.push Texture.new(gosu_image)}
      return textures
    end
  end
end
