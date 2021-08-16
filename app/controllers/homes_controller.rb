class HomesController < ApplicationController
  def top
    if Rails.env.production?
      @cooks = Cook.order("RAND()").limit(10)
    else
      @cooks = Cook.order("RANDOM()").limit(10)
    end
  end

  def about
  end
end