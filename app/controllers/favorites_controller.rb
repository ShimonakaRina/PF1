class FavoritesController < ApplicationController
  def create
    @cook = Cook.find(params[:cook_id])
    favorite = current_user.favorites.new(cook_id: @cook.id)
    favorite.save
    @cook.create_notification_by(current_user)
      respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
    end
  end

  def destroy
    @cook = Cook.find(params[:cook_id])
    favorite = current_user.favorites.find_by(cook_id: @cook.id)
    favorite.destroy
  end
end
