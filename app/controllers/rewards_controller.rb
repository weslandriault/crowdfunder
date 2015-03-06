class RewardsController < ApplicationController
  before_action :load_project

  def new
    @reward = @project.rewards.new
  end

  def create
    @reward = @project.rewards.new(reward_params)
  
    respond_to do |format|
      if @reward.save
        format.html { redirect_to project_path(@project) }
        format.js {}  
      else
        # flash.now[:alert] = @reward.errors.full_messages.to_sentence
          fornat.html { render :new , alert: "Creation failed, please retry" }
          format.js {}
      end
    end
  end

  def edit
    @reward = Reward.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @reward = Reward.find(params[:id])

      respond_to do |format|
      if @reward.update_attributes(reward_params)
        format.html { redirect_to project_path(@project) }
        format.js {}  
      else
        # flash.now[:alert] = @reward.errors.full_messages.to_sentence
          fornat.html { render :edit , alert: "Edit failed, please retry" }
          format.js {}
      end
    end
  end

  def destroy
    @reward = Reward.destroy(params[:id])
    respond_to do |format|
      format.html { redirect_to project_path(@project) }
      format.js
    end
  end

  private
  def reward_params
    params[:reward].permit(:name, :description, :price, :backer_limit, :project_id)
  end 

  def load_project
    @project = Project.find(params[:project_id])
  end

end
