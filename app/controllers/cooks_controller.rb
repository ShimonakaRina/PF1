class CooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  def new
    @cook = Cook.new
  end

  def create
    @cook = Cook.new(cook_params)
    @user = current_user
    @cook.user_id = current_user.id
    tag_list = params[:cook][:tag_ids].split(',')

    ActiveRecord::Base.transaction do
      @cook.save!
      @cook.save_tags(tag_list)
      flash[:notice] = "新規投稿に成功しました！"
      redirect_to cook_path(@cook.id)
    end
    rescue ActiveRecord::RecordInvalid
      flash.now[:notice] = "投稿に失敗しました。必須項目を入力し、字数制限も守ってください。"
      render action: :new

  end

  def rank
    @cooks = Cook.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @cooks = Kaminari.paginate_array(@cooks).page(params[:page]).per(10)

    @rate = CookComment.group(:cook_id).average(:rate) # 投稿ごとの評価の平均値
  end

  def timeline
    @cooks = Cook.where(user_id: [current_user.id, *current_user.following_user.ids]).order(created_at: :desc).page(params[:page]).per(10) # フォローしている人と自分の投稿のみ表示
    @rate = CookComment.group(:cook_id).average(:rate)
  end

  def index
    @cooks = Cook.all.order(created_at: :desc).page(params[:page]).per(10)
    @user = current_user
    @rate = CookComment.group(:cook_id).average(:rate)
  end

  def show
    @cook = Cook.find(params[:id])
    @user = @cook.user
    @cook_comment = CookComment.new

    @cook_comments = @cook.cook_comments.page(params[:page]).per(10)
    @rate = CookComment.where(cook_id: params[:id]).group(:cook_id).average(:rate).values.first
  end

  def edit
    @cook = Cook.find(params[:id])
    @tag_list =@cook.tags.pluck(:name).join(",")
  end

  def update
    @cook = Cook.find(params[:id])
    tag_list = params[:cook][:tag_ids].split(',')
    ActiveRecord::Base.transaction do
     @cook.update!(cook_params)
     @cook.save_tags(tag_list)
     flash[:notice] = "投稿情報を更新しました。"
     redirect_to cook_path(@cook.id)
    end
    rescue ActiveRecord::RecordInvalid
     flash.now[:notice] = "更新に失敗しました。必須項目と字数制限は守ってください"
     render action: :edit


  end

  def destroy
    @cook = Cook.find(params[:id])
    @cook.destroy
    redirect_to cooks_path
  end

  private

  def cook_params
    params.require(:cook).permit(:title, :body, :cook_image, :created_at, :updated_at)
  end

  def ensure_correct_user
    @cook = Cook.find(params[:id])
    if @cook.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to cooks_path
    end
  end
end
