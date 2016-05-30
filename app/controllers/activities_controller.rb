class ActivitiesController < ApplicationController
  before_action :check_login,only: %i[new]
  before_action :find_activity, only: %i[show edit update destroy open close]

  def index
    @activities  = Activity.all
	end

	def new
    @activity = Activity.new
  end

  def create
    @activity= Activity.new(activity_params)
    @activity.user_id = current_user.id
    if @activity.save
      redirect_to @activity
    else
      render 'new'
    end
  end

  def show
    @activity.views+=1
    @activity.save
  end

  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to users_path }
      format.js
    end
  end

  def edit
  end

  def update
    if @activity.update(activity_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def open
    @activity.status = 0
    flash[:success] = "關閉成功"
    @activity.save
    redirect_to users_path
  end

  def close
    @activity.status = 1
    flash[:success] = "開啟成功"
    @activity.save
    redirect_to users_path
  end

  private
  	def find_activity
      @activity=Activity.find(params[:id])
    end

    def activity_params
      params.require(:activity).permit(:title,:content,:summary,:category,:thumb,:status,:date,:place)
    end
end
