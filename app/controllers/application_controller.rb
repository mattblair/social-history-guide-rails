class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  
  # stores id of AdminUser in PaperTrail.whodunnit, which is a string. 
  def user_for_paper_trail
    # or use just current_admin_user, which will store the id
    # then use to_i to join to admin_users table    
    return current_admin_user  #current_admin_user.username 
  end
  
end
