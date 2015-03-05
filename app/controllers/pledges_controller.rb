class PledgesController < ApplicationController
  before_action :load_project

  def new
    @pledge = @project.pledge.new
  end

  def create
    @pledge = @project.pledge.new

    if @pledge.save
      redirect_to project_path(@project)
    else
      flash.now[:alert] = "Your attempt to make a pledge didn't work. Please try again!"
    end
  end

  def destroy
    @pledge = Pledge.find(params[:id])
    @reward.destroy
    redirect_to project_path(@project)
  end

  private
  def pledge_params
    params[:pledge].permit(:amount, :backer_id, :project_id)
  end
  def load_project
    @project = Project.find(params[:project])
  end
end
