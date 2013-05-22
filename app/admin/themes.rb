ActiveAdmin.register Theme do
  
  index do
      column "Title", :sortable => :title do |theme|
            link_to(theme.title, admin_theme_path(theme))
      end
      column :subtitle
      column "Last Updated", :updated_at
      
      default_actions
  end
  
end
