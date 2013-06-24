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

  # index does not have an individual story variable to present audio
  sidebar :audio, :except => :index do
  # always returns nil. should return a local-variable on show & form?
  #sidebar :audio, :if => proc{ defined? story } do
      audio_tag("#{story.audio_filename}.mp3", :controls => true, :type => "audio/mp4")
  end
  
  sidebar :image, :except => :index do
    # if image not specified, show a placeholder here.
    image_tag("#{story.image_name}.jpg", :size => "240x180", :class => "story_image_preview", :alt => "Story Image")
  end
  
  sidebar :image_credits, :except => :index, :partial => "admin/resource/image_credits_sidebar"
  
  sidebar :image_tips do
      ul do
        li "To add an image, type the name of the file in the Image Filename
        field, and put it on Dropbox, or email it to me. Or just enter the URL
        for it if it's already online."
        li "They image won't appear here until I crop it, and add it to the images folder of the website."
      end
  end
  
  sidebar :location,:except => :index do
    if story.latitude != 0.0 && story.longitude != 0.0
      image_tag "http://maps.google.com/maps/api/staticmap?size=240x180&sensor=false&zoom=16&markers=#{story.latitude}%2C#{story.longitude}", :size => "240x180" 
    else
      p "Location not specified, or out of scope of this project."
    end
  end
  
  
  # ===================================================
  # Show
  # ===================================================
  
  show :title => "Story Details" do |story|
    # how do you rename this?! passing title and name don't work
    attributes_table do
      row :title
      row :subtitle
      row :summary
      row :theme_id
      row :guest_id 
      row :twitter_template do
        simple_format story.twitter_template
      end
      row :slug
      row :keywords
      #row :image do
      #  image_tag(ad.image.url)
      #end
      
      # status_tag options:
      # :ok (green)
      # :warning (yellow)
      # :error (red)
      row :workflow_state do |s| 
        status_tag s.workflow_state.to_s, (s.workflow_state_id == 6 ? :ok : :warning)
      end
      
      row :proofreader
    end
    
    #panel "Image Details" do
    #  attributes_table_for story, :image_name, :image_credit, :image_credit_url, :image_copyright_notice, :image_copyright_url, :image_copyright_details
    #end
    
    # or do this as a sidebar?
    
    panel "More Info" do
      attributes_table_for story, :more_info_url, :more_info_title, :more_info_description, :more_info_notes
    end
      
    panel "Editorial Details" do
      attributes_table_for story, :editorial_notes, :photo_notes, :editing_priority, :display_order, :created_at, :updated_at
    end
    
    # or put this in a partial like /app/views/admin/guests/_editorial.html.erb
    #panel "Editorial Partial" do
    #  render 'editorial'
    #end
    
    panel "Audio Transcription" do
      p story.audio_transcription
    end
    
    #active_admin_comments
  end
  
  
  form do |f|                         
    f.inputs "Basic Info" do       
      f.input :title
      f.input :subtitle
      f.input :summary, :label => "Summary (up to ~100 words)", :input_html => { :class => 'autogrow', :rows => 10, :cols => 60  }
      f.input :keywords
      f.input :theme
      f.input :twitter_template, :label => "Twitter Text", :input_html => { :rows => 3, :cols => 20, :maxlength => 120 }, :hint => "Less than 120 characters, to leave space for urls, RTs, etc."
      f.input :slug, :hint => "Auto-generated from name. Letters, numbers and hyphens only. Must start with a letter."
    end
    f.inputs "Interview Details" do
      #f.html audio_tag("#{story.audio_filename}.mp4", :controls => true)
      f.input :guest
      f.input :audio_filename
      f.input :audio_transcription, :input_html => { :class => 'autogrow', :rows => 10, :cols => 60  }
    end
    f.inputs "Image Details" do
      f.input :photo_notes, :label => "Photo Research Notes", :input_html => {:rows => 10, :cols => 60}, :hint => "Not displayed to the public"
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
    f.inputs "More Info" do
      f.input :more_info_url, :label => "More Info URL"
      f.input :more_info_title, :label => "More Info Title"
      f.input :more_info_description, :input_html => {:rows => 5, :cols => 60}, :hint => "Optional"
      f.input :more_info_notes, :input_html => {:rows => 5, :cols => 60}, :label => "More Info Notes", :hint => "Not displayed to the public"
    end
    f.inputs "Editorial Details" do
      f.input :workflow_state
      f.input :media_type, :label => "Format", :hint => "Most stories will be audio interviews"
      f.input :editorial_notes, :label => "Notes"
      f.input :proofreader, :label => "Proofread By:"
      f.input :display_order
      f.input :editing_priority
    end                          
    f.actions
  end
  
end
