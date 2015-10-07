class Maze
  attr_accessor :cells
  attr_accessor :size
  attr_accessor :entrance
  attr_accessor :exit

  def initialize(size)
    @size = size
    @cells = {}
  end

  def generate!
    # Generate all the cells with walls all around them
    @size.times do |x|
      @size.times do |y|
        coords = [x, y]
        @cells[coords] = MazeCell.new(x, y, @size)
      end
    end

    @entrance = [0, (rand * @size).floor] # random cell on left wall
    @cells[@entrance].visited = true
    @exit = [@size -1, (rand * @size).floor] # random cell on left wall
    trail = [@entrance]

    generate_step(@entrance, trail)
  end

  def generate_step(cur_pos, trail)
    return if cur_pos == @exit # If we reached the exit, we're done.

    cell = @cells[cur_pos]

    while true
      new_trail = trail.dup
      next_cell_coords = cell.neighbours.select{|neighbour_coords| !@cells[neighbour_coords].visited }.sample # Pick a random unvisited neighbour
      break if next_cell_coords.nil? # If all neighbors have been visited, we're done here

      next_cell = @cells[next_cell_coords]
      next_cell.visited = true

      # bring down the wall between cells
      cell.walls.delete(next_cell_coords)
      next_cell.walls.delete(cur_pos)

      # go forth and explore
      new_trail << next_cell_coords
      generate_step(next_cell_coords, new_trail)
    end
  end

  # This is not pretty code, but it's a useful debug output
  def console_output(solution_path = nil)
    @size.times do |y|
      if y == 0
        # print first row "roofs"
        @size.times do |x|
          cell = @cells[[x, y]]
          print cell.can_walk?(:up) ? "   " : "___"
        end
        puts ""
      end

      # print all "vertical walls"
      @size.times do |x|
        cell = @cells[[x, y]]
        print x == 0 && !cell.can_walk?(:left) ? "|" : " "
        print console_output_cell_contents(cell.coords, solution_path)
        print cell.can_walk?(:right) ? " " : "|"
      end
      puts ""

      # print all floors
      @size.times do |x|
        cell = @cells[[x, y]]
        print cell.can_walk?(:down) ? "   " : "___"
      end
      puts ""
    end
  end

  def console_output_cell_contents(coords, solution_path)
    return "E" if coords == @entrance
    return "X" if coords == @exit
    return "P" if solution_path.present? && coords.in?(solution_path)
    return " "
  end
end
