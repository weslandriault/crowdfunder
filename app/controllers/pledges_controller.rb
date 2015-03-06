class PledgesController < ApplicationController
  before_action :load_project

  def new
    @pledge = @project.pledges.new
  end

  def create
    @pledge = @project.pledges.new(pledge_params)
    @pledge.backer = current_user
    # @pledge.reward = @pledge.find_reward

    respond_to do |format|
      if @pledge.save
        format.html { redirect_to project_path(@project) }
        @project.amount_raised += @pledge.amount
        @project.save
        format.js {}  
      else
        # flash.now[:alert] = @reward.errors.full_messages.to_sentence
          format.html { render :new , alert: "Your attempt to make a pledge didn't work. Please try again!" }
          format.js {}
      end
    end
  end

  def destroy
    @pledge = Pledge.destroy(params[:id])
    respond_to do |format|
      format.html { redirect_to project_path(@project) }
      format.js
    end
  end

  private
  def pledge_params
    params[:pledge].permit(:amount, :backer_id, :project_id, :reward_id)
  end
  def load_project
    @project = Project.find(params[:project_id])
  end
end
