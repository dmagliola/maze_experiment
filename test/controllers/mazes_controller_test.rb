require 'test_helper'

class MazesControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create maze" do
    post :create, maze: { size: Maze::DEFAULT_SIZE }
    maze = assigns(:maze)
    assert_equal Maze::DEFAULT_SIZE, maze.size
    assert_equal Maze::DEFAULT_SIZE ** 2, maze.cells.count # Assert that maze WAS generated

    solver = assigns(:solver)
    assert_operator solver.solution.length, :>,  Maze::DEFAULT_SIZE # Assert there's a solution
  end
end
