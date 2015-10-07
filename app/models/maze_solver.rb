class MazeSolver
  attr_accessor :maze
  attr_accessor :solution

  def initialize(maze)
    @maze = maze
    @solution = []
  end

  def solve!
    # Do a dumb brute force walk
    # It's a bit more brute force than necessary, so it's slower than it could be, but it's much simpler code
    # The proper way would be doing an A*, whereas instead of going to every cell from each cell, we keep a list of visited cells,
    #   and a queue of cells to visit. For each cell in the queue we add all the unvisited neighbours to the queue, and then we recursively process
    # That guarantees that the first one to reach the exit is the shortest path.
    path = [@maze.entrance]
    step(@maze.entrance, path)
    @solution
  end

  def step(cur_pos, path)
    cell = @maze.cells[cur_pos]

    cell.accessible_neighbours.each do |next_cell_coords|
      next if path.include?(next_cell_coords) # don't backtrack

      new_path = path.dup
      new_path << next_cell_coords

      if next_cell_coords == @maze.exit
        # we reached the exit. record the solution if it's the shortest
        if @solution.blank? || new_path.length < @solution.length
          @solution = new_path
        end
      else
        # explore!
        step(next_cell_coords, new_path)
      end
    end
  end
end
