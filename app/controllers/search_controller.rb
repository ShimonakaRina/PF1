class SearchController < ApplicationController
  def search
    @model = params["search"]["model"]
    @value = params["search"]["value"]
    @how = params["search"]["how"]
    @datas = search_for(@how, @model, @value)
    @datas = @datas.page(params[:page]).per(10)
    @rate = CookComment.group(:cook_id).average(:rate)
  end

  def tag_search
    @cooks = params[:tag_id].present? ? Tag.find(params[:tag_id]).cooks : Cook.all # タグ検索
    @cooks = @cooks.all.order(created_at: :desc).page(params[:page]).per(10) # 検索結果をページネーション
    @rate = CookComment.group(:cook_id).average(:rate)
  end

  private

  def match(model, value) # モデルごとに検索
    if model == 'user'
      User.where(name: value)
    elsif model == 'cook'
      Cook.where(title: value)
    end
  end

  def forward(model, value) # 名前と検索結果が完全一致
    if model == 'User'
      User.where("name LIKE ?", "#{value}%")
    elsif model == 'Cook'
      Cook.where("title LIKE ?", "#{value}%")
    end
  end

  def partical(model, value) # 名前と検索結果が部分一致
    if model == 'user'
      User.where("name LIKE ?", "%#{value}%")
    elsif model == 'cook'
      Cook.where("title LIKE ?", "%#{value}%")
    end
  end

  def search_for(how, model, value)
    case how
      when 'match'
        match(model, value)
      when 'partical'
        partical(model, value)

    end
  end

end
