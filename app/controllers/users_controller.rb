class UsersController < ApplicationController
  before_action :require_user!, only: [:show]
  before_action :already_logged_in!, only: [:new]

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.new(user_params)

    if user.save
      login_user!(user)
      redirect_to user_url(user)
    else
      flash.now[:errors]  = ["Invalid username"]
      @user = User.new
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
