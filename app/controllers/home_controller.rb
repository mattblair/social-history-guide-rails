class HomeController < ApplicationController
  def index
    #@users = User.all
    @themes = Theme.all
  end
end
