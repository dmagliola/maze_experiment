require 'test_helper'

class MazeSolverTest < ActiveSupport::TestCase
  setup do
    @maze = Maze.new(10)
    @maze.generate!
  end
  test "solve a maze" do
    solver = MazeSolver.new(@maze)
    solution = solver.solve!

    # make sure that the solution starts and ends at the right places
    assert_equal @maze.entrance, solution.first
    assert_equal @maze.exit, solution.last

    # make sure that all cells are reachable from the previous cell
    last_cell_coords = solution.first
    solution.each_with_index do |cur_cell_coords, i|
      next if i == 0 # skip the first one
      assert cur_cell_coords.in?(@maze.cells[last_cell_coords].accessible_neighbours), "Can't reach #{cur_cell_coords} from #{last_cell_coords} which has walls: #{@maze.cells[last_cell_coords].walls}"
      last_cell_coords = cur_cell_coords
    end
  end
end
