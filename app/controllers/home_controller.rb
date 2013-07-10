class HomeController < ApplicationController
  def index
    @themes = Theme.where("workflow_state_id = #{ENV['WORKFLOW_STATE_TO_DISPLAY']}").order("display_order")
  end
end
