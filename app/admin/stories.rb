ActiveAdmin.register Story do
  
  index do
      
      column "Title" do |story|
            link_to(story.title, admin_story_path(story))
      end
      #column :audio_filename
      column :guest, :sortable => :guest
      column :theme, :sortable => :theme
      column :display_order
      column "Last Updated", :updated_at
      
      default_actions
  end
  
  # think about a grid layout once images are available
=begin  
  index :as => :grid do |story|
      link_to(image_tag(story.image_name), admin_story_path(story))
    end
=end
end
