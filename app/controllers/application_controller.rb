class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  
  # stores id of AdminUser in PaperTrail.whodunnit, which is a string. 
  # Use to_i to join to admin_users table
  def user_for_paper_trail
    return current_admin_user 
  end
  
end
