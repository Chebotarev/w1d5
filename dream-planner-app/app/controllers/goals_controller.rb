class GoalsController < ApplicationController

  before_action :ensure_owner!, only: [:update, :destroy]

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.owner = current_user
    if @goal.save
      redirect_to user_url(@goal.owner)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to :back
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to user_url(@goal.owner)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:content, :status, :title)
  end

  def ensure_owner!
    goal = Goal.find(params[:id])
    redirect_to root_url unless current_user == goal.owner
  end

end
