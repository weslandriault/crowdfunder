class PledgesController < ApplicationController
  before_action :load_project

  def new
    @pledge = @project.pledges.new
  end

  def create
    @pledge = @project.pledges.new(pledge_params)
    @pledge.backer = current_user

    respond_to do |format|
      if @pledge.save
        format.html { redirect_to project_path(@project) }
        @project.amount_raised += @pledge.amount
        @project.save
        format.js {}  
      else
        # flash.now[:alert] = @reward.errors.full_messages.to_sentence
          fornat.html { render :new , alert: "Your attempt to make a pledge didn't work. Please try again!" }
          format.js {}
      end
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
