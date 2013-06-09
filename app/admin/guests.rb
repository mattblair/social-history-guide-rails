ActiveAdmin.register Guest do
  
  menu :priority => 2
  
  # ===================================================
  # Index
  # ===================================================
  
  # workflow: proposed, draft, deferred, incomplete, edited, published, testing
  scope :proposed
  scope :draft
  scope :deferred
  scope :incomplete
  scope :edited
  scope :published
  scope :testing # only show to admin?
  
  filter :name
  filter :specialty
  
  index do
      column "Name", :sortable => :name do |guest|
            link_to(guest.name, admin_guest_path(guest))
      end
      column :title
      column :specialty
      column "Last Updated", :updated_at
      
      # only show edit in the right column:
      actions :defaults => false do |guest|
        link_to "Edit", edit_admin_guest_path(guest), :class => "member_link"
      end
  end
  
  # ===================================================
  # Sidebars (for all views)
  # ===================================================
  
  # ===================================================
  # Sidebars (for objects)
  # ===================================================
  
  sidebar :image, :except => :index do
      image_tag("#{guest.image_name}.jpg", :size => "240x180", :class => "guest_image_preview", :alt => "Guest Image")
  end
  
  sidebar :image_credits, :except => :index, :partial => "admin/resource/image_credits_sidebar"
  
  # ===================================================
  # Show
  # ===================================================
  
  show :title => "Guest Info" do |guest|
    # how do you rename this?! passing title and name don't work
    attributes_table do
      row :title
      row :organization
      row :specialty
      row :twitter_template do
        simple_format guest.twitter_template
      end
      row :slug
      #row :image do
      #  image_tag(ad.image.url)
      #end
      
      # status_tag options:
      # :ok (green)
      # :warning (yellow)
      # :error (red)
      row :workflow_state do |g| 
        status_tag g.workflow_state.to_s, (g.workflow_state_id == 6 ? :ok : :warning)
      end
      row :release_confirmed do |g| 
        status_tag (g.release_confirmed ? "On File" : "Needed"), (g.release_confirmed ? :ok : :error)
      end
      row :proofreader
    end
    
    panel "Biography" do
      p guest.bio
    end
    
    panel "Quote" do
      p guest.quote
    end
        
    panel "Editorial Notes" do
      # this will not inject the unwanted title
      #attributes_table_for guest, :workflow_state, :editorial_notes, :release_confirmed
      p guest.editorial_notes
      # if you nest attributes_table in a panel, it titles the whole structure "Guest Details"
    end
    
    # or put this in a partial like /app/views/admin/guests/_editorial.html.erb
    #panel "Editorial Partial" do
    #  render 'editorial'
    #end
    
    #active_admin_comments
  end
  
  # ===================================================
  # Editing
  # ===================================================
  
  form do |f|                         
    f.inputs "Basic Information" do       
      f.input :name
      f.input :title
      f.input :organization
      f.input :specialty, :input_html => {:rows => 1, :cols => 60}
      f.input :bio, :hint => "Up to 250 words", :input_html => { :class => 'autogrow', :rows => 10, :cols => 60  }
      f.input :twitter_template, :label => "Twitter Text", :input_html => { :rows => 3, :cols => 20, :maxlength => 120 }, :hint => "Less than 120 characters, to leave space for urls, RTs, etc."
      f.input :slug, :hint => "Auto-generated from name. Letters, numbers and hyphens only. Must start with a letter."
    end
    f.inputs "Image Details" do
      f.input :image_name, :label => "Image Filename"
      f.input :image_credit, :label => "Image Credit", :hint => "Displayed below the image"
      f.input :image_credit_url, :label => "Image Credit URL", :input_html => {:rows => 1, :cols => 60}, :hint => "Image credit text links to this web address"
      f.input :image_copyright_notice, :label => "Image Copyright Notice", :hint => "Visible to the public"
      f.input :image_copyright_url, :label => "Image Copyright URL", :input_html => {:rows => 1, :cols => 60}, :hint => "Copyright notice links to this web address"
      f.input :image_copyright_details, :label => "Image Copyright Details", :input_html => {:rows => 5, :cols => 60}, :hint => "Private details of copyright and licensing"
    end
    f.inputs "Additional Information" do 
      f.input :quote, :required => false, :input_html => { :class => 'autogrow', :rows => 5, :cols => 60  }
      f.input :guest_url_text, :label => "Guest Link Text", :hint => "The text which will appear as the link for this guest"
      f.input :guest_url, :label => "Guest URL", :hint => "The actual web address the text will link to"
    end
    f.inputs "Editorial Details" do
      f.input :workflow_state
      f.input :editorial_notes, :label => "Notes", :input_html => {:rows => 8, :cols => 60}
      f.input :proofreader, :label => "Proofread By:"
      f.input :display_order
      f.input :release_confirmed
    end
    f.actions
  end
  
end
