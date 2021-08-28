class RelationshipsController < ApplicationController
  def follow
    current_user.follow(params[:id])
    @user = User.find(params[:id])
    @user.create_notification_follow!(current_user) # フォロー通知
    redirect_to request.referer
  end
  
  def unfollow
    current_user.unfollow(params[:id])
    redirect_to request.referer
  end
  
  def followings
		@user = User.find(params[:user_id])
		@users = @user.following_user.page(params[:page]).per(10)
  end
  
  def followers
		@user = User.find(params[:user_id])
		@users = @user.follower_user.page(params[:page]).per(10)
  end
end
