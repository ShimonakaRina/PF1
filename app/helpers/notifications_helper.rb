module NotificationsHelper
 def notification_form(notification)
      @visiter = notification.visiter
      @cook_comment = nil
      your_cook = link_to 'あなたの投稿', cook_path(notification), style:"font-weight: bold;"
      @visiter_comment = notification.cook_comment_id
      #notification.actionがfollowかfavoriteかcommentか
      case notification.action.downcase
        when "follow" then
          tag.a(notification.visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
        when "favorite" then
          tag.a(notification.visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:cook_path(notification.cook_id), style:"font-weight: bold;")+"にいいねしました"
        when "cook_comment" then
            #@cook_comment = CookComment.find_by(id: @visiter_comment)&.content
            tag.a(@visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:cook_path(notification.cook_id), style:"font-weight: bold;")+"にコメントしました"
      end
 end
  
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
    
end
