class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @cooks = @user.cooks.page(params[:page]).per(5)
    @cooks1 = @user.cooks.all
    @rate = CookComment.group(:cook_id).average(:rate)
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
     flash[:notice] = "ユーザー情報の更新に失敗しました。必須項目の入力と字数制限を守ってください。"
     render action: :edit
    end
  end

  def user_favorites
    @user = User.find(params[:user_id])
    favorites = Favorite.where(user_id: @user.id).pluck(:cook_id)
    @cooks = Kaminari.paginate_array(Cook.find(favorites)).page(params[:page]).per(10)
    @rate = CookComment.group(:cook_id).average(:rate)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to user_path
    end
  end
end
