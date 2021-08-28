class CookCommentsController < ApplicationController

  def create
    @cook = Cook.find(params[:cook_id])
		@cook_comment = CookComment.new(cook_comment_params)
		@cook_comment.cook_id = @cook.id
		@cook_comment.user_id = current_user.id

		if @cook_comment.save
		   @cook.create_notification_comment!(current_user, @cook_comment.id) # コメント
		   redirect_to cook_path(@cook)
		else
			flash[:notice] = "コメント投稿に失敗しました。本文と評価は必ず入力してください" 
			redirect_to cook_path(@cook)
    end
  end

  def destroy
    @cook = Cook.find(params[:cook_id])
  	cook_comment = @cook.cook_comments.find(params[:id])
		cook_comment.destroy
  end

  private

	def cook_comment_params
		params.require(:cook_comment).permit(:comment, :rate, :updated_at, :created_at)
	end
end
