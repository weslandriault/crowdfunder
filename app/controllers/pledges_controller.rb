class PledgesController < ApplicationController
  before_action :load_project

  def new
    @pledge = @project.pledges.new
  end

  def create
    @pledge = @project.pledges.new(pledge_params)
    @pledge.backer = current_user
    if @pledge.save
      redirect_to project_path(@project) 
      @project.amount_raised += @pledge.amount
      @project.save
    else
      flash.now[:alert] = "Your attempt to make a pledge didn't work. Please try again!"
      render :new
    end
  end

  def destroy
    @pledge = Pledge.find(params[:id])
    @pledge.destroy
    redirect_to project_path(@project)
  end

  private
  def pledge_params
    params[:pledge].permit(:amount, :backer_id, :project_id)
  end
  def load_project
    @project = Project.find(params[:project_id])
  end
end
