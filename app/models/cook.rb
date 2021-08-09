class Cook < ApplicationRecord
  belongs_to :user
  attachment :cook_image
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :cook_comments, dependent: :destroy
  has_many  :tag_relationships, dependent: :destroy
  has_many  :tags, through: :tag_relationships
  def create_notification_by(current_user)
        notification = current_user.active_notifications.new(
          cook_id: id,
          visited_id: user_id,
          action: "Favorite"
        )
        notification.save if notification.valid?
  end

    def create_notification_comment!(current_user, cook_comment_id)
        # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
        temp_ids = CookComment.select(:user_id).where(cook_id: id).where.not(user_id: current_user.id).distinct
        temp_ids.each do |temp_id|
            save_notification_comment!(current_user, cook_comment_id, temp_id['user_id'])
        end
        # まだ誰もコメントしていない場合は、投稿者に通知を送る
        save_notification_comment!(current_user, cook_comment_id, user_id) if temp_ids.blank?
    end

    def save_notification_comment!(current_user, cook_comment_id, visited_id)
        # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
        notification = current_user.active_notifications.new(
          cook_id: id,
          cook_comment_id: cook_comment_id,
          visited_id: visited_id,
          action: 'Cook_comment'
        )
        # 自分の投稿に対するコメントの場合は、通知済みとする
        if notification.visiter_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
    end

    def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
    end

    def save_tags(savecook_tags)
      current_tags = self.tags.pluck(:name) unless self.tags.nil?
      old_tags = current_tags - savecook_tags
      new_tags = savecook_tags - current_tags

      old_tags.each do |old_name|
        self.tags.delete Tag.find_by(name: old_name)
      end

      new_tags.each do |new_name|
        cook_tag = Tag.find_or_create_by(name: new_name)
        self.tags << cook_tag
      end
    end
    def self.sort(selection)
      case selection
      when 'new'
          return all.order(created_at: :DESC)
      when 'old'
          return all.order(created_at: :ASC)
      when 'likes'
          return find(Favorite.group(:cook_id).order(Arel.sql('count(cook_id) desc')).pluck(:cook_id))
      when 'dislikes'
          return find(Favorite.group(:cook_id).order(Arel.sql('count(cook_id) asc')).pluck(:cook_id))
      end
    end
end
