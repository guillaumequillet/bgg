module BGG
  class AABB
    attr_reader :origin, :size
    def initialize(origin: Vector.new, size: Vector.new)
      @origin, @size = origin, size
    end

    def collides?(other)
      return !(@origin.x > other.origin.x + other.size.x ||
        @origin.x + @size.x < other.origin.x ||
        @origin.y > other.origin.y + other.size.y ||
        @origin.y + @size.y < other.origin.y)
    end

    def draw(color: Gosu::Color::WHITE, style: :solid, border_size: 1)
      case style
      when :solid
        Gosu.draw_rect(@origin.x, @origin.y, @size.x, @size.y, color, @origin.z)
      when :outline
        Gosu.draw_rect(@origin.x, @origin.y, @size.x, border_size, color, @origin.z)
        Gosu.draw_rect(@origin.x, @origin.y + @size.y - border_size, @size.x, border_size, color, @origin.z)
        Gosu.draw_rect(@origin.x, @origin.y, border_size, @size.y, color, @origin.z)
        Gosu.draw_rect(@origin.x + @size.x - border_size, @origin.y, border_size, @size.y, color, @origin.z)
      end
    end
  end
end
