require 'json'

module BGG
  class TiledMap
    def initialize(filename)  
      @data = JSON.parse(File.read(filename))
      @width, @height = @data["width"], @data["height"]
      @tile_width, @tile_height = @data["tilewidth"], @data["tileheight"]
      @layers = @data["layers"]
      @tiles = []

      @data["tilesets"].each do |tileset|
        tileset = JSON.parse(File.read("#{File.dirname(filename)}/#{File.basename(tileset["source"])}"))
        tileset_image = tileset["image"]
        @tiles += Gosu::Image.load_tiles("#{File.dirname(filename)}/#{tileset_image}", tileset["tilewidth"].to_i, tileset["tileheight"].to_i, retro: true)
      end
    end
  
    def draw
      @layers.each do |layer|
        @height.times do |y|
          @width.times do |x|
            tile = y * @width + x
            tile_id = layer["data"][tile] - 1
            @tiles[tile_id].draw(x * @tile_width, y * @tile_height, 0)
          end
        end
      end
    end
  end
end
