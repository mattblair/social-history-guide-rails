ActiveAdmin.register Tidbit do
  
  config.sort_order = "publication_date_desc"
  
  menu :priority => 4
  
  # workflow: proposed, draft, deferred, incomplete, edited, published, testing
  scope :proposed
  scope :draft
  scope :deferred
  scope :incomplete
  scope :edited
  scope :published
  scope :testing # only show to admin?
  
  filter :title
  filter :media_type_id
  filter :theme_id
  filter :publication_date
  filter :editorial_notes
  
  index do
      
      column "Title" do |story|
            link_to(tidbit.title, admin_tidbit_path(tidbit))
      end
      column :guest, :sortable => :guest
      column :theme, :sortable => :theme
      column :publication_date
      column "Last Updated", :updated_at
      
      # only show edit in the right column:
      actions :defaults => false do |tidbit|
        link_to "Edit", edit_admin_tidbit_path(tidbit), :class => "member_link"
      end
  end
  
  sidebar :main_image, :except => :index do
      image_tag("#{tidbit.image_name}.jpg", :size => "240x180", :class => "guest_tidbit_preview", :alt => "Tidbit Image")
  end
  
  sidebar :image_credits, :except => :index, :partial => "admin/resource/image_credits_sidebar"
  
  sidebar :tips do
      ul do
        li "Second List First Item"
        li "Second List Second Item"
      end
  end
  
  form do |f|                         
    f.inputs "Basic Info" do       
      f.input :title                  
      f.input :publication_date, :as => :date_select
      f.input :body, :label => "Body (up to 250 words)", :input_html => { :class => 'autogrow', :rows => 10, :cols => 60  }
      f.input :theme
      f.input :media_type, :label => "Format", :hint => "Some selections require additional media information below"
      f.input :year, :label => "Year (optional)", :required => false
      f.input :twitter_template, :label => "Twitter Text", :input_html => { :rows => 3, :cols => 20, :maxlength => 120 }, :hint => "Less than 120 characters, to leave space for urls, RTs, etc."
      f.input :slug, :hint => "Auto-generated from name. Letters, numbers and hyphens only. Must start with a letter."
    end
    f.inputs "Geocoding" do 
      f.input :latitude, :input_html => { :size => 16 }
      f.input :longitude, :input_html => { :size => 16 }
    end
    f.inputs "Image Details" do
      f.input :image_name, :label => "Image Filename"
      f.input :image_caption, :label => "Image Caption"
      f.input :image_credit, :label => "Image Credit", :hint => "Displayed below the image"
      f.input :image_credit_url, :label => "Image Credit URL", :input_html => {:rows => 1, :cols => 60}, :hint => "Image credit text links to this web address"
      f.input :image_copyright_notice, :label => "Image Copyright Notice", :hint => "Visible to the public"
      f.input :image_copyright_url, :label => "Image Copyright URL", :input_html => {:rows => 1, :cols => 60}, :hint => "Copyright notice links to this web address"
      f.input :image_copyright_details, :label => "Image Copyright Details", :input_html => {:rows => 5, :cols => 60}, :hint => "Private details of copyright and licensing"
    end
    f.inputs "Additional Media" do 
      f.input :audio_filename
      f.input :source
      f.input :source_url, :input_html => { :rows => 1, :cols => 60, :maxlength => 400 }
    end
    f.inputs "Media Copyright Details" do
      f.input :media_copyright_notice, :label => "Media Copyright Notice", :hint => "Visible to the public"
      f.input :media_copyright_url, :label => "Media Copyright URL", :input_html => {:rows => 1, :cols => 60}, :hint => "Copyright notice links to this web address"
      f.input :media_copyright_details, :label => "Media Copyright Details", :input_html => {:rows => 5, :cols => 60}, :hint => "Private details of copyright and licensing"
    end
    f.inputs "Editorial Details" do
      f.input :workflow_state
      f.input :editorial_notes, :label => "Notes"
    end                          
    f.actions
  end
  
end
