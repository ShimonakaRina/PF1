class HomesController < ApplicationController
  def top
    @cooks = Cook.order("RANDOM()").limit(10)
  end
  
  def about
  end
end