class MazeCell
  attr_accessor :coords
  attr_accessor :visited
  attr_accessor :neighbours
  attr_accessor :walls

  def initialize(x, y, maze_size)
    @coords = [x, y]
    @visited = false

    # Initialize the neighbors
    @neighbours = []
    @neighbours << left  unless x <= 0
    @neighbours << up unless y <= 0
    @neighbours << right unless x >= maze_size - 1
    @neighbours << down unless y >= maze_size - 1

    # Start with walls in every direction
    @walls = @neighbours.dup
  end

  def accessible_neighbours
    @neighbours - @walls
  end

  def can_walk?(direction)
    accessible_neighbours.include?(self.send(direction))
  end

  def up
    [@coords.first, @coords.last - 1]
  end

  def down
    [@coords.first, @coords.last + 1]
  end

  def left
    [@coords.first - 1, @coords.last]
  end

  def right
    [@coords.first + 1, @coords.last]
  end
end