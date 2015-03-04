class RewardsController < ApplicationController
  before_action :load_project

  def new
    @reward = @project.rewards.new
  end

  def create
    @reward = @project.rewards.new(reward_params)

    if @reward.save
      redirect_to project_path(@project)
    else
      # flash.now[:alert] = @reward.errors.full_messages.to_sentence
      flash.now[:alert] = "You lil bitch done goofed!!"
      render :new
    end

  end

  def edit
    @reward = Reward.find(params[:id])
  end

  def update
    @reward = Reward.find(params[:id])
    if @reward.update_attributes(reward_params)
      redirect_to project_path(@project)
    else
      flash.now[:alert] = "You lil bitch done goofed!!"
      render :edit
    end
  end

  def destroy
    @reward = Reward.find(params[:id])
    @reward.destroy
    redirect_to project_path(@project)
  end

  private
  def reward_params
    params[:reward].permit(:name, :description, :price, :backer_limit, :project_id)
  end 

  def load_project
    @project = Project.find(params[:project_id])
  end

end
