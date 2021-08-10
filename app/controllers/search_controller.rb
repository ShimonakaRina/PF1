class SearchController < ApplicationController
  def search
    @model = params["search"]["model"]
    @value = params["search"]["value"]
    @how = params["search"]["how"]
    @datas = search_for(@how, @model, @value)
    @rate = CookComment.group(:cook_id).average(:rate)
  end
  
  def tag_search
    @cooks = params[:tag_id].present? ? Tag.find(params[:tag_id]).cooks : Cook.all
    @rate = CookComment.group(:cook_id).average(:rate)
  end

  private

  def match(model, value)
    if model == 'user'
      User.where(name: value)
    elsif model == 'cook'
      Cook.where(title: value)
    end
  end

  def forward(model, value)
    if model == 'User'
      User.where("name LIKE ?", "#{value}%")
    elsif model == 'ook'
      Cook.where("title LIKE ?", "#{value}%")
    end
  end

  def backward(model, value)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}")
    elsif model == 'cook'
      Cook.where("title LIKE ?", "%#{value}")
    end
  end

  def partical(model, value)
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
      when 'forward'
        forward(model, value)
      when 'backward'
        backward(model, value)
      when 'partical'
        partical(model, value)
      
    end
  end
  
end
