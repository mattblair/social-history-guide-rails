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
  
  sidebar :help do
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
      f.input :year, :label => "Year (optional)", :required => false
    end
    f.inputs "Geocoding" do 
      f.input :latitude, :input_html => { :size => 16 }
      f.input :longitude, :input_html => { :size => 16 }
    end
    f.inputs "Media Information" do 
      f.input :media_type
      f.input :audio_filename
      f.input :image_name     
      f.input :image_caption  
      f.input :image_credit   
      f.input :source
      f.input :source_url, :input_html => { :rows => 3, :cols => 50, :maxlength => 400 }
      f.input :twitter_template, :label => "Twitter Text", :input_html => { :rows => 3, :cols => 20, :maxlength => 120 }, :hint => "Less than 120 characters, to leave space for urls, RTs, etc."
    end
    f.inputs "Editorial Details" do
      f.input :editorial_notes, :label => "Notes"
      f.input :workflow_state
    end                          
    f.actions
  end
  
end
