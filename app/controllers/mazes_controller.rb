class MazesController < ApplicationController
  def new
    @maze = Maze.new(Maze::DEFAULT_SIZE)
  end

  def create
    @maze = Maze.new(maze_params[:size].to_i)
    @maze.generate!
    @solver = MazeSolver.new(@maze)
    @solver.solve!
    render :show # Bit of an aberration here... Again, time is of the essence
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def maze_params
      params.require(:maze).permit(:size)
    end
end
