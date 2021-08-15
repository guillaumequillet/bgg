require 'json'

module BGG
  class TiledMap
    def initialize(filename: '', display: :view_2d)  
      @display = display
      @data = JSON.parse(File.read(filename))
      @width, @height = @data['width'], @data['height']
      @tile_width, @tile_height = @data['tilewidth'], @data['tileheight']
      @layers = @data['layers']
      @tiles = []
      @textures = []

      @data['tilesets'].each do |tileset|
        path = "#{File.dirname(filename)}/#{tileset['image']}"
        tile_width = tileset['tilewidth'].to_i
        tile_height = tileset['tileheight'].to_i
        case @display
        when :view_2d
          @tiles += Gosu::Image.load_tiles(path, tile_width, tile_height, retro: true)
        when :view_3d
          @textures += Texture.load_tiles(filename: path, tile_width: tile_width, tile_height: tile_height)
        end
      end

      @blocks = []
      @layers.each do |layer|
        if layer.has_key?('objects') # layer of objets / blocks
          layer['objects'].each do |object|
            origin = Vector.new(x: object['x'], y: object['y'])
            size = Vector.new(x: object['width'], y: object['height'])
            @blocks.push AABB.new(origin: origin, size: size)
          end
        end
      end
    end
  
    def draw
      case @display
      when :view_2d
        draw_2D
      when :view_3d
        draw_3D
      end
    end

    def draw_2D
      @layers.each do |layer|
        if layer.has_key?('data') # layer of tiles
          @height.times do |y|
            @width.times do |x|
              tile = y * @width + x
              tile_id = layer['data'][tile] - 1 # Tiled starts count at 1, not 0
              if tile_id != -1
                @tiles[tile_id].draw(x * @tile_width, y * @tile_height, 0)
              end
            end
          end
        end
      end

      @blocks.each {|block| block.draw(color: Gosu::Color::RED, style: :outline, border_size: 2)}
    end

    def draw_3D
      unless defined?(@display_list)
        @display_list = glGenLists(1)
        glNewList(@display_list, GL_COMPILE)
          @layers.each do |layer|
            if layer.has_key?('data') # layer of tiles
              @height.times do |y|
                @width.times do |x|
                  tile = y * @width + x
                  tile_id = layer['data'][tile] - 1 # Tiled starts count at 1, not 0
                  if tile_id != -1
                    glBindTexture(GL_TEXTURE_2D, @textures[tile_id].get_id)
                    glPushMatrix
                    glScalef(@tile_width, 1, @tile_height)
                    glTranslatef(x, 0, y)
                    glBegin(GL_QUADS)
                      glTexCoord2d(0, 1); glVertex3f(0, 0, 0)
                      glTexCoord2d(0, 0); glVertex3f(0, 0, 1)
                      glTexCoord2d(1, 0); glVertex3f(1, 0, 1)
                      glTexCoord2d(1, 1); glVertex3f(1, 0, 0)
                    glEnd
                    glPopMatrix
                  end
                end
              end
            end
          end          
        glEndList
      end
      glCallList(@display_list)
    end
  end
end
