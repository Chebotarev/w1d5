class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @goals = @user.goals.includes(:comments)
    @user_comments = @user.comments.includes(:author)
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
