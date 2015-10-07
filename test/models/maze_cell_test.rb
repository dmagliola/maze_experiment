require 'test_helper'

class MazeTest < ActiveSupport::TestCase
  test "generate a cell, its neighbours and walls"  do
    coords = [5, 5]
    expected_neighbours = [[4, 5], [5, 4], [5, 6], [6, 5]]
    c = MazeCell.new(coords.first, coords.last, 10)
    assert_equal coords, c.coords
    assert_equal false, c.visited
    assert_equal expected_neighbours, c.neighbours.sort
    assert_equal expected_neighbours, c.walls.sort

    coords = [0, 5]
    expected_neighbours = [[0, 4], [0, 6], [1, 5]]
    c = MazeCell.new(coords.first, coords.last, 10)
    assert_equal coords, c.coords
    assert_equal false, c.visited
    assert_equal expected_neighbours, c.neighbours.sort
    assert_equal expected_neighbours, c.walls.sort
  end

  [:up, :down, :left, :right].each do |direction|
    test "walkability towards #{direction} and accessible_neighbours" do
      coords = [5, 5]
      c = MazeCell.new(coords.first, coords.last, 10)
      assert_equal false, c.can_walk?(direction)
      assert_empty c.accessible_neighbours

      c.walls.delete(c.send(direction))
      assert_equal true, c.can_walk?(direction)
      assert_equal [c.send(direction)], c.accessible_neighbours
    end
  end
end
