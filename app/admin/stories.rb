ActiveAdmin.register Story do
  
  config.sort_order = "display_order_asc"
  config.per_page = 50
  
  menu :priority => 3
  
  # workflow: proposed, draft, deferred, incomplete, edited, published, testing
  scope :proposed
  scope :draft
  scope :deferred
  scope :incomplete
  scope :edited
  scope :published
  scope :testing # only show to admin?
  
  filter :title
  filter :subtitle
  filter :theme_id
  filter :guest_id
  filter :editorial_notes
  filter :keywords
  
  index do
    
      column "Title" do |story|
            link_to(story.title, admin_story_path(story))
      end
      #column :audio_filename
      column :guest, :sortable => :guest
      column :theme, :sortable => :theme
      #column :display_order
      column "Last Updated", :updated_at
      
      # only show edit in the right column:
      # delete prepends destroy_ and create prepends new_
      actions :defaults => false do |story|
        link_to "Edit", edit_admin_story_path(story), :class => "member_link"
      end
  end
  
  # think about a grid layout once images are available -- including audio player?

  #index :as => :grid do |story|
  #    link_to(image_tag(story.image_name), admin_story_path(story))
  #end

  sidebar :tips do
      ul do
        li "Second List First Item"
        li "Second List Second Item"
      end
  end
  
  sidebar :image, :except => :index do
      image_tag("#{story.image_name}.jpg", :size => "240x180", :class => "story_image_preview", :alt => "Story Image")
  end
  
  # index does not have an individual story variable to present audio
  sidebar :audio, :except => :index do
  # always returns nil. should return a local-variable on show & form?
  #sidebar :audio, :if => proc{ defined? story } do
      audio_tag("#{story.audio_filename}.mp4", :controls => true)
  end
  
  form do |f|                         
    f.inputs "Basic Info" do       
      f.input :title
      f.input :subtitle
      f.input :summary, :label => "Summary (up to ~100 words)", :input_html => { :class => 'autogrow', :rows => 10, :cols => 60  }
      f.input :keywords
      f.input :theme
      f.input :twitter_template, :label => "Twitter Text", :input_html => { :rows => 3, :cols => 20, :maxlength => 120 }, :hint => "Less than 120 characters, to leave space for urls, RTs, etc."
    end
    f.inputs "Interview Details" do
      #f.html audio_tag("#{story.audio_filename}.mp4", :controls => true)
      f.input :guest
      f.input :audio_filename
      f.input :audio_transcription, :input_html => { :class => 'autogrow', :rows => 10, :cols => 60  }
    end
    f.inputs "Image Details" do
      f.input :image_name, :label => "Image Filename"
      f.input :image_credit, :label => "Image Credit", :hint => "Displayed below the image"
      f.input :image_credit_url, :label => "Image Credit URL", :input_html => {:rows => 1, :cols => 60}, :hint => "Image credit text links to this web address"
      f.input :image_copyright_notice, :label => "Image Copyright Notice", :hint => "Visible to the public"
      f.input :image_copyright_url, :label => "Image Copyright URL", :input_html => {:rows => 1, :cols => 60}, :hint => "Copyright notice links to this web address"
      f.input :image_copyright_details, :label => "Image Copyright Details", :input_html => {:rows => 5, :cols => 60}, :hint => "Private details of copyright and licensing"
    end
    f.inputs "Geocoding" do 
      f.input :latitude, :input_html => { :size => 16 }
      f.input :longitude, :input_html => { :size => 16 }
    end
    f.inputs "Editorial Details" do
      f.input :workflow_state
      f.input :media_type, :label => "Format", :hint => "Most stories will be audio interviews"
      f.input :editorial_notes, :label => "Notes"
      f.input :display_order
      f.input :editing_priority
    end                          
    f.actions
  end
  
end
