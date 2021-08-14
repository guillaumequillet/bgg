module BGG
  class AABB
    attr_reader :origin, :size
    def initialize(origin: origin, size: size)
      @origin, @size = origin, size
    end
  end
end
