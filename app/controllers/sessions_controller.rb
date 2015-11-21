class SessionsController < ApplicationController
  before_action :already_logged_in!, only: [:new]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password],
    )

    if @user
      login_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid username/password"]
      @user = User.new
      render :new
    end
  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end

end
