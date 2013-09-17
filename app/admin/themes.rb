ActiveAdmin.register Theme do
  
  #config.sort_order = "title_asc"
  config.sort_order = "display_order_asc"
  
  menu :priority => 1
  
  # workflow: proposed, draft, deferred, incomplete, edited, published, testing
  scope :proposed
  scope :draft
  scope :deferred
  scope :incomplete
  scope :edited
  scope :published
  #scope :testing # only show to admin?
  
  filter :title
  filter :summary
  filter :keywords
  filter :editorial_notes
  
  index do
      column "Title", :sortable => :title do |theme|
            link_to(theme.title, admin_theme_path(theme))
      end
      column :subtitle
      column "Last Updated", :updated_at
      
      #default_actions
      # only show edit in the right column:
      actions :defaults => false do |theme|
        link_to "Edit", edit_admin_theme_path(theme), :class => "member_link"
      end
  end
  
  sidebar :theme_illustration, :except => :index do
      image_tag("#{theme.image_name}.jpg", :size => "240x180", :class => "guest_theme_preview", :alt => "Theme Image")
  end
  
  sidebar :image_credits, :except => :index, :partial => "admin/resource/image_credits_sidebar"
  
  sidebar :related_stories, :except => :index do
    theme.stories.each do |story|
      li link_to(story.title, admin_story_path(story))
    end
  end
  
  sidebar :related_tidbits, :except => :index do
    theme.tidbits.each do |tidbit|
      li link_to(tidbit.title, admin_tidbit_path(tidbit))
    end
  end
  
  form do |f|                         
    f.inputs "Basic Info" do       
      f.input :title
      f.input :subtitle
      f.input :summary, :input_html => { :class => 'autogrow', :rows => 10, :cols => 60}, :hint => "Up to ~100 words"
      f.input :keywords, :hint => "About 100 characters"
      f.input :twitter_template, :label => "Twitter Text", :input_html => { :rows => 3, :cols => 20, :maxlength => 120 }, :hint => "Less than 120 characters, to leave space for urls, RTs, etc."
      f.input :slug, :hint => "Auto-generated from title. Letters, numbers and hyphens only. Must start with a letter."
    end
    f.inputs "Image Details" do
      f.input :image_name, :label => "Image Filename"
      f.input :image_credit, :label => "Image Credit", :hint => "Displayed below the image"
      f.input :image_credit_url, :label => "Image Credit URL", :input_html => {:rows => 1, :cols => 60}, :hint => "Image credit text links to this web address"
      f.input :image_copyright_notice, :label => "Image Copyright Notice", :hint => "Visible to the public"
      f.input :image_copyright_url, :label => "Image Copyright URL", :input_html => {:rows => 1, :cols => 60}, :hint => "Copyright notice links to this web address"
      f.input :image_copyright_details, :label => "Image Copyright Details", :input_html => {:rows => 5, :cols => 60}, :hint => "Private details of copyright and licensing"
    end
    f.inputs "Note:" do
        "<div class=\"editing-note\">
        <ul>
        <li>Might not make sense to have a single location for a theme...</li>
        </ul>
        </div>".html_safe
    end
    f.inputs "Geocoding" do 
      f.input :latitude, :input_html => { :size => 16 }
      f.input :longitude, :input_html => { :size => 16 }
      f.input :zoom_level
    end
    f.inputs "Editorial Details" do
      f.input :workflow_state
      f.input :editorial_notes, :label => "Notes"
      f.input :proofreader, :label => "Proofread By:"
      f.input :display_order
    end                          
    f.actions
  end
  
end
