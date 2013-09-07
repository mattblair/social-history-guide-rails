ActiveAdmin.register Story do
  
  config.sort_order = "display_order_asc"
  config.per_page = 25
  
  menu :priority => 3
  
  # workflow: proposed, draft, deferred, incomplete, edited, published, testing
  scope :proposed
  scope :draft
  scope :deferred
  scope :incomplete
  scope :edited
  scope :published
  #scope :testing # only show to admin?
  
  filter :title
  filter :subtitle
  filter :theme_id
  filter :guest_id
  filter :image_status_id
  filter :editorial_notes
  filter :keywords
  
  index do
    
      column "Title" do |story|
            link_to(story.title, admin_story_path(story))
      end
      #column :guest, :sortable => :guest
      column :theme, :sortable => :theme
      column "Text Added?" do |s|
        if s.summary.empty? || s.subtitle.empty?
          text_edited = false
        else
          text_edited = (s.summary.length > 10 && s.subtitle.length > 10) || s.proofreader_id > 0
        end
        status_tag (text_edited ? "Yes" : "No"), (text_edited ? :ok : :error)
      end
      column "Photo Notes?" do |s|
        has_photo_notes = !s.photo_notes.nil? && s.photo_notes !=""
        status_tag (has_photo_notes ? "Yes" : "No"), (has_photo_notes ? :ok : :error)
      end
      column "Photo Status" do |s|
        photo_status = s.image_status.human_name
        if s.image_status.name == "available"
          status_style = :ok
        elsif s.image_status.name == "tbd"
          status_style = :error
        else
          status_style = :warning
        end
        status_tag photo_status, status_style
      end
      #column "Has Photo?" do |s|
      #  has_photo = !s.image_name.nil? && s.image_name !=""
      #  status_tag (has_photo ? "Yes" : "No"), (has_photo ? :ok : :error)
      #end
      
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
      #audio_tag("#{story.audio_filename}.mp3", :controls => true, :type => "audio/mp4")
      kyc_audio_tag(story.audio_filename)
  end
  
=begin
  sidebar :image, :except => :index do
    # if image not specified, show a placeholder here.
    image_tag("#{story.image_name}.jpg", :size => "240x180", :class => "story_image_preview", :alt => "Story Image")    
  end
=end
  
  sidebar :current_image, :except => :index, :partial => "admin/resource/story_image_sidebar"
  
  sidebar :image_credits, :except => :index, :partial => "admin/resource/image_credits_sidebar"
  
  sidebar :image_tips do
      ul do
        li "Images may be in jpeg or TIFF format. A PDF file is acceptable for documents. Please ask first about other formats."
        li "Images must have a resolution of 2,048 x 1,536 pixels (width x height) or greater. The bigger the better, especially if we will need to crop the image."
        li "To add an image, type the name of the file in the Image Filename
        field, and put it on Dropbox, or email it to me. Or just enter the URL
        for it if it's already online."
        li "The image won't appear here until I crop it, and add it to the images folder of the website."
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
      
      # status_tag options:
      # :ok (green)
      # :warning (yellow)
      # :error (red)
      row :workflow_state do |s| 
        status_tag s.workflow_state.to_s, (s.workflow_state_id == 6 ? :ok : :warning)
      end
      
      row :proofreader
    end
    
    panel "More Info" do
      attributes_table_for story, :more_info_title, :more_info_url, :more_info_description, :more_info_notes
    end
      
    panel "Photo Notes" do
      div do
        simple_format story.photo_notes
      end
    end
    
    panel "Editorial Details" do
      div do
        simple_format story.editorial_notes
      end
      
      attributes_table_for story, :image_status, :editing_priority, :display_order, :created_at, :updated_at
    end
    
    # or put this in a partial like /app/views/admin/guests/_editorial.html.erb
    #panel "Editorial Partial" do
    #  render 'editorial'
    #end
    
    panel "Audio Transcription" do
      div do
        simple_format story.audio_transcription
      end
    end
    
    #active_admin_comments
  end
  
  
  form do |f|
    f.actions           
    f.inputs "Basic Info" do       
      f.input :title
      f.input :subtitle
      f.input :summary, :label => "Summary (up to ~100 words)", :hint => "Refer to guest by last name. Other details will be displayed in a guest section of the story view.", :input_html => { :class => 'autogrow', :rows => 6, :cols => 60  }
      f.input :keywords
      f.input :theme
      f.input :twitter_template, :label => "Twitter Text", :input_html => { :rows => 3, :cols => 20, :maxlength => 120 }, :hint => "Less than 120 characters, to leave space for urls, RTs, etc."
      f.input :slug, :hint => "Auto-generated from name. Letters, numbers and hyphens only. Must start with a letter."
    end
    f.inputs "More Info" do
      f.input :more_info_title, :label => "More Info Title"
      f.input :more_info_url, :label => "More Info URL"
      f.input :more_info_description, :input_html => {:rows => 5, :cols => 60}, :hint => "Optional"
      f.input :more_info_notes, :input_html => {:rows => 5, :cols => 60}, :label => "More Info Notes", :hint => "Not displayed to the public"
    end
    f.inputs "Interview Details" do
      f.input :guest
      f.input :audio_filename
      f.input :audio_transcription, :input_html => { :class => 'autogrow', :rows => 10, :cols => 60  }
    end
    f.inputs "Editorial Details" do
      f.input :workflow_state
      f.input :media_type, :label => "Format", :hint => "Most stories will be photo_interview type"
      f.input :editorial_notes, :label => "Notes", :input_html => { :class => 'autogrow', :rows => 10, :cols => 60  }
      f.input :proofreader, :label => "Proofread By:"
      f.input :display_order
      f.input :editing_priority
    end
    f.inputs "Image Details" do
      f.input :photo_notes, :label => "Photo Research Notes", :input_html => {:rows => 10, :cols => 60}, :hint => "Not displayed to the public"
      f.input :image_name, :label => "Image Filename"
      f.input :image_caption, :label => "Caption"
      f.input :image_credit, :label => "Image Credit", :hint => "Displayed below the image"
      f.input :image_credit_url, :label => "Image Credit URL", :input_html => {:rows => 1, :cols => 60}, :hint => "Image credit text links to this web address"
      f.input :image_copyright_notice, :label => "Image Copyright Notice", :hint => "Visible to the public"
      f.input :image_copyright_url, :label => "Image Copyright URL", :input_html => {:rows => 1, :cols => 60}, :hint => "Copyright notice links to this web address"
      f.input :image_copyright_details, :label => "Image Copyright Details", :input_html => {:rows => 5, :cols => 60}, :hint => "Private details of copyright and licensing"
      f.input :image_status
    end
    f.inputs "Geocoding" do 
      f.input :latitude, :input_html => { :size => 16 }
      f.input :longitude, :input_html => { :size => 16 }
    end
    f.inputs "Map Data" do
      f.input :map_data, :input_html => { :rows => 10, :cols => 60 }, :hint => "Recommended: validate GeoJSON with geojsonlint.com"
      f.input :map_data_type, :hint => "Might not be used. Leave as 0 for now."
    end
    f.actions
  end
end
