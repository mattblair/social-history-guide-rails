ActiveAdmin.register AdminUser do     
  
  # to hide the admin users completely:
  #menu false
  
  # to show it only to admins:
  #ActiveAdmin.register AdminUser do
  #    menu :if => proc{ current_admin_user.can_edit_admin_users? }
  #end
  # docs:
  # http://activeadmin.info/docs/2-resource-customization.html#customize_the_menu
  
  index do                            
    column :email                     
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :sign_in_count             
    default_actions                   
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "Admin Details" do
      f.input :human_name
      f.input :username
      f.input :email                  
      f.input :password               
      f.input :password_confirmation, :label => "Confirm Password (for verification)"
    end                               
    f.actions                         
  end                                 
end                                   
