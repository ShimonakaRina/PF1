class CookCommentsController < ApplicationController

  def create
    @cook = Cook.find(params[:cook_id])
		@cook_comment = CookComment.new(cook_comment_params)
		@cook_comment.cook_id = @cook.id
		@cook_comment.user_id = current_user.id
		if @cook_comment.save
		flash[:notice] = "コメントを投稿しました。"
		# @cook.create_notification_comment!(current_user, @cook_comment.id)
		else
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
