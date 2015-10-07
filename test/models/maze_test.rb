require 'test_helper'

class MazeTest < ActiveSupport::TestCase
  test "generate a maze" do
    maze_size = 10
    maze = Maze.new(maze_size)
    maze.generate!

    assert_equal maze_size ** 2, maze.cells.count

    # make sure all the cells exist
    maze_size.times do |x|
      maze_size.times do |y|
        coords = [x, y]
        assert_not_nil maze.cells[coords]
        assert maze.cells[coords].visited # make sure it was visited as part of the maze generation process, ie, that all cells are there
      end
    end

    # make sure there's an entrance and an exit on the left and right walls
    assert_equal 0, maze.entrance.first
    assert_operator maze.entrance.last, :>=, 0
    assert_operator maze.entrance.last, :<, maze_size

    assert_equal maze_size - 1, maze.exit.first
    assert_operator maze.exit.last, :>=, 0
    assert_operator maze.exit.last, :<, maze_size

    # testing the walls is left as an exercise for the reader :-)
    # i'm also not testing the console_output code since in a real app we'd get
    # rid of that
  end
end
