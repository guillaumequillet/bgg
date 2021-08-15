require 'json'

module BGG
  class TiledMap
    def initialize(filename)  
      @data = JSON.parse(File.read(filename))
      @width, @height = @data['width'], @data['height']
      @tile_width, @tile_height = @data['tilewidth'], @data['tileheight']
      @layers = @data['layers']
      @tiles = []

      @data['tilesets'].each do |tileset|
        @tiles += Gosu::Image.load_tiles("#{File.dirname(filename)}/#{tileset['image']}", tileset['tilewidth'].to_i, tileset['tileheight'].to_i, retro: true)
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
  end
end
