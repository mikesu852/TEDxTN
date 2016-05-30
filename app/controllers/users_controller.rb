class UsersController < ApplicationController
    before_action :check_login,only: %i[index edit]
	  def index
      @article = Article.all
      @activities = Activity.all
    end

    def signup
    	@user = User.new
  	end

   	def create
    	@user=User.new(user_params)
    	if @user.save
        if params[:user][:avatar].present?
          render :crop
        else
          flash[:success] = "註冊成功"
          redirect_to root_path
        end
      else
        flash[:danger] = "註冊失敗"
        render 'signup'
      end
  	end

  	def create_login_session
    	@user =User.find_by_email(params[:email])
    	if @user && @user.authenticate(params[:password])
      		session[:user_id]= @user.id
          flash[:success] = "登入成功"
      		redirect_to root_path
    	else
          if @user
            flash[:danger] = "登入失敗,密碼錯誤"
          else
            flash[:danger] = "登入失敗,信箱或密碼錯誤"
          end
      		redirect_to :login
    	end
  	end


  	def logout
    	session[:user_id]=nil
      flash[:danger] = "已將您登出"
    	redirect_to root_path
  	end


    def edit
      @user = current_user
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        if params[:user][:avatar].present?
          render :crop
        else
          flash[:success] = "更新成功"
          redirect_to user_path(@user)
        end
      else
        flash[:danger] = "更新失敗"
        render 'edit'
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      session[:user_id]=nil
      flash[:success] = "刪除帳號成功"
      redirect_to root_path
    end

    def show
      @user = User.find(params[:id])
    end

  	private
   		def user_params
     		params.require(:user).permit(:crop_x, :crop_y, :crop_w, :crop_h,:avatar,:name,:email,:profile,:password)
   		end

end
