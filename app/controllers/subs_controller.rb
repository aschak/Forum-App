class SubsController < ApplicationController
  # TODO
  before_action :require_moderator!, only: [:edit, :update, :destroy]

  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = current_user.subs.new(sub_params)

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = ["Sub already exists"]
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = ["Invalid title"]
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
  end

  # def destroy
  #
  # end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
