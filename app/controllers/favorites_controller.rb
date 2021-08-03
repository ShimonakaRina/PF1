class FavoritesController < ApplicationController
  def create
    @cook = Cook.find(params[:cook_id])
    favorite = @cook.favorites.new(user_id: current_user.id)
    favorite.save
    redirect_to request.referer
  end
  
  def destroy
    @cook = Cook.find(params[:cook_id])
    favorite = @cook.favorites.find_by(user_id: current_user.id)
    favorite.destroy
    redirect_to request.referer
  end
end
