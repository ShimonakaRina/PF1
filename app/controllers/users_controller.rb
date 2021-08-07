class UsersController < ApplicationController
  def index
    @user = current_user
    @users = User.order("RANDOM()").limit(10)
  end
  
  def show
    @user = User.find(params[:id])
    @cooks = @user.cooks
  end
  
  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
     flash[:notice] = "ユーザー情報の更新をしました。"
     redirect_to user_path(@user.id)
    else
     render action: :edit
    end
  end 
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
end
